module CorevistAPI
  module Filters::Links
    class BaseLink
      def perform(data)
        field_name = self.class.name.downcase.tr('link', '')
        return unless (field_value = data.params.extract!(field_name.to_sym))

        data.query = data.query.where("#{field_name}": field_value)
      end
    end
  end
end
