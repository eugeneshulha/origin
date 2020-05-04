class CorevistAPI::Translations::Base::CacheKey
  delegate :microsite, :location, to: CorevistAPI::Translation

  def initialize(key)
    @key = key.to_s
  end

  def by_location_and_microsite(translation = nil)
    return fetch_by_location_and_microsite unless location?(translation)

    @key = translation.location_used + @key
    by_microsite(translation)
  end

  def by_location(translation = nil)
    return fetch_by_location unless location?(translation)

    @key = translation.location_used + @key
    by_locale(translation)
  end

  def by_microsite(translation = nil)
    return fetch_by_microsite unless microsite?(translation)

    @key = translation.microsite + @key
    by_locale(translation)
  end

  def by_locale(translation = nil)
    return fetch_by_locale if translation.blank?

    @key = translation.locale + @key
  end

  def default
    @key = FastGettext.default_locale + @key
  end

  def with_translation?(method)
    method(method).parameters.present?
  end

  private

  def location?(translation)
    translation.present? && translation.location_used.present?
  end

  def microsite?(translation)
    translation.present? && translation.microsite.present?
  end

  def fetch_by_locale
    @key = FastGettext.locale + @key
  end

  def fetch_by_location
    return by_locale if location.blank?

    @key = location + @key
    by_locale
  end

  def fetch_by_microsite
    return by_locale if microsite.blank?

    @key = microsite + @key
    by_locale
  end

  def fetch_by_location_and_microsite
    return by_microsite if location.blank?

    @key = location + @key
    by_microsite
  end
end
