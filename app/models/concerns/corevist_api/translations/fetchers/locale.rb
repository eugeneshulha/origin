class CorevistAPI::Translations::Fetchers::Locale < CorevistAPI::Translations::Fetchers::Base
  def call(key)
    CorevistAPI::Translation.key_class.new(key).by_locale
  end
end
