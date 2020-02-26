module CorevistAPI
  module Forms
    class Admin::Roles::UpdateForm < BaseForm
      include CorevistAPI::FormValidations

      ID_KEY = 'id'.freeze

      def permitted_params
        %w[id title description active]
      end

      def rejected_keys
        super << ID_KEY
      end
    end
  end
end
