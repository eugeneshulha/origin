module CorevistAPI
  module Services
    module Admin
      module Roles
        class IndexService < CorevistAPI::Services::Base::IndexService
          ALLOWED_TO_SEARCH_CRITERIA = %w[title user_id active created_by updated_by created_at].freeze

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
  end
end
