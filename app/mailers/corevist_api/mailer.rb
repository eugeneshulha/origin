module CorevistAPI
  class Mailer < BaseMailer
    def user_registration(form)
      @form = form
      mail to: form['email']
    end

    def submit_invoice_question(form, user_id)
      user = CorevistAPI::User.find_by(uuid: user_id)

      @form = form
      mail to: user.email
    end

    def submit_salesdoc_question(form, user_id)
      user = CorevistAPI::User.find_by(uuid: user_id)

      @form = form
      mail to: user.email
    end

    def pay_invoices_confirmation(user_id, payment_number)
      user = CorevistAPI::User.find_by(uuid: user_id)
      @number = payment_number

      mail to: user.email
    end
  end
end
