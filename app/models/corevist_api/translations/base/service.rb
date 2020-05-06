module CorevistAPI::Translations::Base::Service
  include CorevistAPI::Translations::DbSearch::Base

  attr_reader :location, :microsite

  # main method of translation mechanism
  # locale is equal to FastGettext.locale by default
  def translation(key, locale)
    return unless ActiveRecord::Base.connected? && table_exists?

    search(key, locale)&.value
  end

  def default_query(key)
    { key: key, locale: FastGettext.default_locale, status: :active, microsite_id: nil, location_used: nil }
  end

  # init class variables for the TranslationStorage during request's life cycle
  def init(microsite, location)
    @microsite = microsite
    @location = location
  end

  private

  def search(key, locale)
    db_search(where(key: key, locale: locale, status: :active)) || default(key)
  end
end
