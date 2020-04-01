module CorevistAPI
  module Services::Sortable
    extend ActiveSupport::Concern

    included do
      private

      def sort_by_param(array)
        return array if @params[:sort_by].blank?

        array = array.sort_by do |item|
          item.send(@params[:sort_by]) if item.respond_to?(@params[:sort_by])
        end

        array.reverse! if @params[:order]&.to_sym == :desc
        array
      end

      def filter_by_query(array)
        return array if @params[:q].blank?

        array.select do |element|
          matches = look_up(element)
          matches.present?
        end
      end

      def look_up(element)
        element.instance_variables.select do |variable|
          variable = variable.to_s.tr(':@', '')
          next false if element.value_for_key(variable).is_a?(Array)

          element.value_for_key(variable).to_s.downcase.include?(@params[:q].downcase)
        end
      end
    end
  end
end
