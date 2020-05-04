class CorevistAPI::Translations::Fetchers::LocationMicrosite < CorevistAPI::Translations::Fetchers::Base
  def call(key)
    CorevistAPI::Translation.key_class.new(key).by_location_and_microsite
  end
end
