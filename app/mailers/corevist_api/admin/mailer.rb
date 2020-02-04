module CorevistAPI
  class Admin::Mailer < ApplicationMailer
    default template_path: 'corevist_api/mailer/admin'

    def user_registration(form)
      @form = form
      mail to: form.email
    end
  end
end
