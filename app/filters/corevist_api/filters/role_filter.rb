module CorevistAPI
  module Filters
    class RoleFilter < BaseFilter
      chain << :active_link << :title_link << :created_by_link << :updated_by_link << :description_link

      def initialize(*args)
        @result = CorevistAPI::Filters::Results::RoleResult.new(*args)
      end
    end
  end
end
