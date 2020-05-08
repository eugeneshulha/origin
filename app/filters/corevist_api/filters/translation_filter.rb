module CorevistAPI
  module Filters
    class TranslationFilter < BaseFilter
      chain << :key_link << :df_translation_link << :cst_translation_link << :locale_link << :microsite_id_link <<
        :status_link << :updated_by_link

      def initialize(*args)
        @result = CorevistAPI::Filters::Results::TranslationResult.new(*args)
      end
    end
  end
end
