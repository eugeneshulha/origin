module CorevistAPI
  module Forms
    class Admin::Roles::ShowForm < BaseForm
      validate_component :show_role_form, on_page: :show_role_page

      def permitted_params
        %w[id]
      end
    end
  end
end
