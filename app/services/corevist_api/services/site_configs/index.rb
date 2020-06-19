module CorevistAPI::Services::SiteConfigs
  class Index < CorevistAPI::Services::BaseService

    def call
      perform
    end

    private

    def perform
      hash = {
        microsites: CorevistAPI::Microsite.all.inject([]) { |memo, el| memo << { text: el.name, value: el.id }},
        user_types: CorevistAPI::UserType.all.inject([]) { |memo, el| memo << { text: el.title, value: el.value }},
        user_classifications: CorevistAPI::UserClassification.all.inject([]) { |memo, el| memo << { text: el.title, value: el.title }},
        locales: Settings.locales.inject([]) { |memo, el| memo << { text: el, value: el }},
        sales_areas: CorevistAPI::SalesArea.all.inject([]) { |memo, el| memo << { text: el.title, value: el.title }},
        timezones: Settings.timezones.inject([]) { |memo, el| memo << { text: el[0], value: el[1] }},
        number_formats: Settings.number_formats.inject([]) { |memo, el| memo << { text: el[0], value: el[1] }},
        date_formats: Settings.date_formats.inject([]) { |memo, el| memo << { text: el[0], value: el[1] }},
        time_formats: Settings.time_formats.inject([]) { |memo, el| memo << { text: el[0], value: el[1] }},
      }

      result(hash)
    end
  end
end
