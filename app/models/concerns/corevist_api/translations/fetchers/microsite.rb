class CorevistAPI::Translations::Fetchers::Microsite < CorevistAPI::Translations::Fetchers::Base
  def call(key)
    CorevistAPI::Translation.key_class.new(key).by_microsite
  end
end
