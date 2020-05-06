module CorevistAPI
  module Services
    class Admin::Translations::IndexService < Base::IndexService
      ALLOWED_SEARCH_CRITERIA = %w[key df_translation cst_translation locale microsite status updated_by].freeze

      private

      def filter
        criteria = ALLOWED_SEARCH_CRITERIA.each_with_object({}) do |criteria, memo|
          memo[criteria] = @params[criteria].to_s.strip
        end

        criteria.delete_if { |_, v| v.blank? }
        service_for("#{@params[:type]}_filter", @params[:scope], criteria).call
      end
    end
  end
end
