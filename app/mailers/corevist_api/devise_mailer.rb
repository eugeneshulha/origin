module CorevistAPI
  class DeviseMailer < Devise::Mailer
    helper CorevistAPI::DeviseMailerHelper

    def template_paths
      paths = super
      paths.insert(2, 'corevist_api/mailer/devise_mailer')
      paths
    end
  end
end
