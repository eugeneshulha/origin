module CorevistAPI
  module Admin
    class Mailer < ApplicationMailer
      default template_path: 'corevist_api/mailer/admin'

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
    end
  end
end
