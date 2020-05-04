module CorevistAPI::Translations::Base::Service
  include CorevistAPI::Translations::DbSearch::Base
  # TODO: Review caching and po files support
  # include CorevistAPI::Translations::Base::Cache
  # include CorevistAPI::Translations::Files::Po
  attr_reader :location, :microsite

  # main method of translation mechanism
  # locale is equal to FastGettext.locale by default
  def translation(key, locale)
    return unless ActiveRecord::Base.connected? && table_exists?

    search(key, locale)&.value
  end

  def used_translations
    Context::Base[:used_translations] ||= {}
  end

  def default_query(key)
    { key: key, locale: FastGettext.default_locale, status: :active, microsite_id: nil, location_used: nil }
  end

  # init class variables for the TranslationStorage during request's life cycle
  def init(microsite, location)
    @microsite = microsite
    @location = location
  end

  def find_override(key, location)
    real_location = @location
    @location = location
    record = nil

    begin
      record = search(key, FastGettext.locale)
    rescue StandardError => e
      Rails.logger.error("#{e.message}\n#{e.backtrace.first}")
    ensure
      @location = real_location
    end

    record
  end

  # decorator for the cache keys
  def key_class
    CorevistAPI::Translations::Base::CacheKey
  end

  # Objects that will be invoked for writing translation in cache with specific key
  # first argument in return statement is proc that sorts translations collection for specific translations
  # second argument in return statement is method name of CacheKey class to generate translation's cache key
  def initializers
    @initializers ||= [
      CorevistAPI::Translations::Initializers::Locale.instance,
      CorevistAPI::Translations::Initializers::Microsite.instance,
      CorevistAPI::Translations::Initializers::Location.instance,
      CorevistAPI::Translations::Initializers::LocationMicrosite.instance
    ]
  end

  # Objects that will be invoked for fetching translation from cache by specific key
  def fetchers
    @fetchers ||= [
      CorevistAPI::Translations::Fetchers::LocationMicrosite.instance,
      CorevistAPI::Translations::Fetchers::Location.instance,
      CorevistAPI::Translations::Fetchers::Microsite.instance,
      CorevistAPI::Translations::Fetchers::Locale.instance,
      CorevistAPI::Translations::Fetchers::Default.instance
    ]
  end

  private

  # method to gsub microsite from translation key
  def get_microsite(key)
    CorevistAPI::Microsite.pluck(:name).find { |m| key.end_with?("_#{m}") && key.gsub("_#{m}", '') != ::MICROSITE_LABEL }
  end

  def search(key, locale)
    db_search(where(key: key, locale: locale, status: :active)) || default(key)
  end
end
