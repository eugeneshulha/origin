module CorevistAPI::Services::Admin::Themes
  class IndexService < CorevistAPI::Services::Base::IndexService
    ALLOWED_TO_SEARCH_CRITERIA = %w[title user_id active created_by updated_by created_at].freeze

    private

    def filter
      p = ALLOWED_TO_SEARCH_CRITERIA.each_with_object({}) do |criteria, memo|
        memo[criteria] = @params[criteria].to_s.strip
      end

      p.delete_if { |_, v| v.blank? }

      service_for("#{@params[:type]}_filter", @params[:scope], p).call
    end
  end
end
