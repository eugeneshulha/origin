class CorevistAPI::Translations::Fetchers::Location < CorevistAPI::Translations::Fetchers::Base
  def call(key)
    CorevistAPI::Translation.key_class.new(key).by_location
  end
end
