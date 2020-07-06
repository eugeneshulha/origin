module CorevistAPI::Services::Admin::Translations
  class FilterService < CorevistAPI::Services::BaseService
    private

    def perform
      filter_result = CorevistAPI::Filters::TranslationFilter.new(@params, @object).run
      result(filter_result.data)
    end
  end
end
