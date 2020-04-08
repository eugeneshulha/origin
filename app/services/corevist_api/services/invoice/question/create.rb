module CorevistAPI
  module Services::Invoice::Question
    class Create < CorevistAPI::Services::BaseServiceWithForm
      private

      def perform
        user = CorevistAPI::Context.current_user
        Mailer.submit_invoice_question(@form.to_json, user.to_json).deliver_later
        Admin::Mailer.submit_invoice_question(@form.to_json, user.to_json).deliver_later

        result
      end
    end
  end
end
