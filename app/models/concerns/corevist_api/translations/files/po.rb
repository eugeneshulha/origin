module CorevistAPI::Translations::Files::Po
  DEFAULT_FILE_NAME =  'translations'

  # method to convert po file record to database translation record
  def convert(po_entry, locale)
    mcr_site = get_microsite(po_entry.msgid)
    po_entry.msgid.gsub!("_#{mcr_site}", '') if mcr_site.present?

    new(key: po_entry.msgid,
        df_translation: po_entry.msgstr,
        locale: locale,
        status: :active,
        microsite: mcr_site)
  end

  def from_po(file, locale)
    GetPomo::PoFile.parse(File.read(file), parse_obsoletes: true)
      .reject { |t| t.msgid.nil? || t.msgstr.nil? }
      .uniq(&:msgid)
      .map { |t| CorevistAPI::Translation.convert(t, locale) }
  end

  def to_po(filters)
    default_filters = Hash.new

    query = filters.map do |name, value|
      next CorevistAPI::Translation.arel_table[name].gt(value) if name == :updated_at

      CorevistAPI::Translation.arel_table[name].matches("%#{value}%")
    end.inject(&:and)

    default_filters[:locale] = Const::App.configs[:languages] unless filters.include?(:locale)

    CorevistAPI::Translation.where(query).where(default_filters).map do |t|
      msgid = if block_given?
        yield(t)
      else
        t.microsite_id.present? ? "#{t.key}_#{t.microsite}" : t.key
      end

      msgstr = t.cst_translation.to_s.empty? ? t.df_translation : t.cst_translation

      ["msgid \"#{msgid}\"", "msgstr \"#{msgstr}\""].join("\n")
    end.join("\n\n")
  end

  def upsert(translation, field)
    is_default = field == :df_translation
    is_custom = field == :cst_translation
    old = CorevistAPI::Translation.where(translation.upsert_query(ignore_status: is_default)).first

    if old && !translation.df_translation.empty?
      old.update_column(field, translation.df_translation)
    elsif !translation.df_translation.empty? && is_custom
      translation.tap do |t|
        t.cst_translation = t.df_translation
        t.df_translation = nil
      end.save
    elsif !translation.df_translation.empty? && is_default
      translation.save
    end
  end
end
