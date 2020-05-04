module Translations::Controller::Admin
  def translations
    respond_to do |format|
      format.html
      format.json do
        render json: paginate_translations
      end
    end
  end

  def new_translation
    @translation = Translation.new(key: params[:key],
                                   location_used: params[:back],
                                   cst_translation: params[:value],
                                   locale: current_user.language,
                                   status: :active,
                                   microsite: current_user.microsite)

    render :edit_translation
  end

  def edit_translation
    if params[:id].present?
      @translation = Translation.find_by_id(params[:id])
    elsif params[:key].present?
      @translation = Translation.find_override(params[:key], params[:back])
    end

    unless @translation
      @translation = Translation.new(key: params[:key],
                                     locale: current_user.language,
                                     status: :active)
      flash[:error] = _('msg|record_not_exists')
    end
  end

  def upsert_translation
    @translation = Translation.find_by_id(params[:id]) || Translation.new
    back = params[:back] if params[:back].present?

    params.permit!.to_h.each do |key, value|
      value = value.empty? ? nil : value

      if @translation.respond_to?("#{key}=")
        @translation.send("#{key}=", value)
      end
    end

    is_create = @translation.new_record?

    if @translation.save
      flash[:info] = is_create ? _('msg|translation_created') : _('msg|translation_updated')
      Translation.update_cache(@translation)

      redirect_to back || { action: :translations }
    else
      render :edit_translation
    end
  end

  def delete_translation
    @translation = Translation.find(params[:id])
    back = params[:back] if params[:back].present?

    if @translation.destroy
      flash[:info] = _('msg|translation_deleted')
      Translation.update_cache(@translation)

      redirect_to back || { action: :translations }
    else
      render :edit_translation
    end
  end

  def reload_cache
    Translation.reload_cache
    flash[:info] = _('msg|cache_reloaded')

    redirect_to action: :translations
  end

  def import_translations
    begin
      valid_form = params[:file].present? && params[:locale].present?
      errors = Array.new

      if valid_form
        Translation.from_po(params[:file].tempfile.path, params[:locale]).each do |t|
          unless Translation.upsert(t, :cst_translation)
            errors << "#{t.key} -> #{t.errors.messages.values.join("\n")}"
          end
        end

        flash[:info] = _('msg|translations_imported')
        flash[:error] = errors.join("\n") unless errors.empty?
      else
        flash[:error] = _('msg|translation_form_error')
      end
    rescue => exc
      Debug::PrettyData.print(exc.message, level: :error, title: 'EXCEPTION')
      flash[:error] = exc.message
    end

    redirect_to action: :translations
  end

  def export_translations
    filters = {}

    params.permit!.to_h.each do |key, value|
      filters[key] = value if Translation.column_names.include?(key)
    end

    if filters['locale'].blank?
      flash[:error] = 'Please select a locale'
      redirect_to action: :translations
    else
      f_name = "#{params[:locale]}_#{Time.zone.now.to_s.gsub(' ', '_')}.po"
      send_data Translation.to_po(filters.symbolize_keys), filename: f_name
    end
  end

  def translations_page_info
    if current_user.present? && current_user.is_b2b?
      render json: { authorized: true,
                     html: render_to_string(layout: false,
                                            template: 'admin/translations_page_info',
                                            locals: { translations: session[:used_translations],
                                                      back_url: params[:back_url]
                                            }) }
    else
      render json: { authorized: false }
    end

    session[:used_translations] = nil
  end

  private

  def paginate_translations
    translations, count = search_for_translations(prepare_query(params[:columns]))

    {
      draw: params[:draw],
      recordsTotal: count,
      recordsFiltered: count,
      data: translations
    }
  end

  def search_for_translations(query)
    translations = Translation.where(query).limit(params[:length]).offset(params[:start]).map  do |t|
      view_context.tr_datatable_row(t)
    end

    [translations, Translation.where(query).count]
  end

  def prepare_query(json_columns)
    all_locales = Const::App.configs[:languages]
    columns = json_columns.values.map do |column|
      [column[:data], column.dig(:search, :value)]
    end.to_h.symbolize_keys

    query = columns.map do |search, value|
      next if value.blank?

      if value.to_sym == :-
        Translation.arel_table[search].eq(nil)
      else
        if search.to_sym == :updated_at
          Translation.arel_table[search].gt(value)
        else
          Translation.arel_table[search].matches("%#{value}%")
        end
      end
    end.compact.inject(:and)

    query.present? ? query : { locale: all_locales }
  end
end
