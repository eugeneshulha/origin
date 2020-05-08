module CorevistAPI
  module Filters::Links
    class BaseLink
      def perform(data)
        field_name = self.class.name.split('::').last.to_s.gsub('Link', '').underscore
        return unless (field_value = data.params.extract!(field_name))

        data.query = data.query.where("#{field_name}": field_value)
      end
    end
  end
end
