module CorevistAPI
  module Forms
    class Admin::Partners::IndexForm < CorevistAPI::Forms::BaseForm
      validate_component :admin_user_partners_modal_form, on_page: :partners_index

      def one_out_of_params
        %w[number name city postal_code]
      end
    end
  end
end
