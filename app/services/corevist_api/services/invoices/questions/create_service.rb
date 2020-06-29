module CorevistAPI::Services::Invoices::Questions
  class CreateService < CorevistAPI::Services::BaseServiceWithForm
    private

    def perform
      user = CorevistAPI::Context.current_user
      CorevistAPI::Mailer.submit_invoice_question(@form.as_json, user.uuid).deliver_later
      CorevistAPI::Admin::Mailer.submit_invoice_question(@form.as_json, user.uuid).deliver_later

      result
    end
  end
end
