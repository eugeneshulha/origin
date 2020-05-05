module CorevistAPI::Translations::Base::Model
  extend ActiveSupport::Concern

  included do
    include CorevistAPI::Translations::Base::Callbacks
    extend CorevistAPI::Translations::Base::Service

    alias_method :to_json, :value
    alias_method :to_s, :value
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

  def value
    cst_translation.nil? ? df_translation : cst_translation
  end

  def custom?
    df_translation.blank?
  end
end
