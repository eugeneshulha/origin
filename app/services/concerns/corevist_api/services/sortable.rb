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
          v = element.instance_variables.keep_if do |variable|
            variable.to_s.tr(':@', '')
            element.value_for_key(variable).to_s.include?(@params[:q].downcase)
          end

          v.present?
        end
      end
    end
  end
end
