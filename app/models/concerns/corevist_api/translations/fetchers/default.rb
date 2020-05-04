class CorevistAPI::Translations::Fetchers::Default < CorevistAPI::Translations::Fetchers::Base
  def call(key)
    CorevistAPI::Translation.key_class.new(key).default
  end
end
