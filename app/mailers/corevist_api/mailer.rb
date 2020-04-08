module CorevistAPI
  class Mailer < BaseMailer
    def user_registration(form)
      @form = form
      mail to: form.email
    end

    def submit_invoice_question(form, user)
      @form = form
      mail to: user.email
    end

    def submit_salesdoc_question(form, user)
      @form = form
      mail to: user.email
    end

    def pay_invoices_confirmation(user, payment_number)
      @user = user
      @number = payment_number

      mail to: user.email
    end
  end
end
