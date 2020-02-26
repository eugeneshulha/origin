module CorevistAPI
  module Forms
    class Admin::Roles::CreateForm < BaseForm
      include CorevistAPI::FormValidations

      def permitted_params
        %w[title description active]
      end

      def params_key
        :role
      end
    end
  end
end
