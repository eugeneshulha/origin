module CorevistAPI::Translations::Cache::Base
  def fetch(key, &block)
    # translation = nil

    # fetchers.each do |fetcher|
    #   translation = @current[fetcher.call(key)]
    #   break if translation
    # end

    translation = try_get_translation(key, &block)

    # if translation.is_a?(String) || translation.is_a?(FalseClass)
    #   used_translations[key] = translation
    # end

    # translation
  end

  def cached?(locale, loaded: false)
    switch_to(FastGettext.text_domain, locale)
    @current[:locale_loaded] ||= loaded
  end

  def digest
    Digest::MD5.hexdigest(@store.to_s)
  end

  def full_reload
    @store.clear
  end

  def write(key, value)
    @current[key] = value
  end

  def key?(key)
    @current.key?(key)
  end

  def backend
    @current
  end

  # initializes cache for available languages
  def init(locale)
    available_locales = Settings.locales&.flatten&.uniq || [locale]
    available_locales.each(&method(:process_locale))
  end

  private

  def process_locale(locale)
    switch_to(FastGettext.text_domain, locale)

    CorevistAPI::Translation.where(locale: locale, status: :active).each do |t|
      next if t.cache_key.blank?

      @current[t.cache_key] = t.value
    end

    cached?(locale, loaded: true)
  end

  def try_get_translation(key)
    translation = @current[key]

    if translation
      return JSON.load(translation)
    end

    block_result = yield if block_given?

    handle_missing_translation(key) && return if block_result.nil?

    if block_result.is_a?(CorevistAPI::Translation)
      translation = @current[block_result.cache_key] = block_result.value
    else
      translation = @current[key] = JSON.dump(block_result)
    end

    translation
  end

  def handle_missing_translation(key)
    used_translations[key] = key
    @current[key] = JSON.dump(false)
  end
end
