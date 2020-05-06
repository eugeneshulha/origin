module CorevistAPI
  module Services::Admin::Translations
    class FilterService < CorevistAPI::Services::BaseService
      def call
        filter_result = CorevistAPI::Filters::TranslationFilter.new(@params, @object).run
        result(filter_result.data)
      end
    end
  end
end
