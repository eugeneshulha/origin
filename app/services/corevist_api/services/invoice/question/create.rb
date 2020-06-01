module CorevistAPI::Services::Invoice::Question
  class Create < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      user = CorevistAPI::Context.current_user
      CorevistAPI::Mailer.submit_invoice_question(@form.as_json, user.uuid).deliver_later
      CorevistAPI::Admin::Mailer.submit_invoice_question(@form.as_json, user.uuid).deliver_later

      result
    end
  end
end
