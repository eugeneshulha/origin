module CorevistAPI
  module Services
    class Admin::Users::IndexService < Base::IndexService
      ALLOWED_TO_SEARCH_CRITERIA = %w[username email last_name first_name microsite_id phone].freeze

      private

      def filter
        p = ALLOWED_TO_SEARCH_CRITERIA.inject({}) do |memo, criteria|
          memo[criteria] = @params[criteria].to_s.strip
          memo
        end

        p.delete_if {|k, v| v.blank? }

        service_for("#{@params[:type]}_filter", @params[:scope], p).call
      end
    end
  end
end
