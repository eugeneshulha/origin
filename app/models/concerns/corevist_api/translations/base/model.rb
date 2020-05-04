module CorevistAPI::Translations::Base::Model
  extend ActiveSupport::Concern

  I18N_KEY_MARKER = '%s_i18n_%s'.freeze

  included do
    include Callbacks
    extend Service

    alias_method :to_json, :value
    alias_method :to_s, :value
  end

  # checks if translation is not Corevist gem translation
  def custom?
    default_translation.blank?
  end

  # hash of params to check if the same record already in the database
  def upsert_query(ignore_status: false)
    {
      key: key,
      locale: locale,
      microsite_id: microsite_id,
      location_used: location_used
    }.tap { |query| query[:status] = status unless ignore_status }
  end

  def cache_key(options = {})
    options[:init].present? ? @cache_key = calculate_cache_key : @cache_key
  end

  def value
    cst_translation.nil? ? df_translation : cst_translation
  end
end
