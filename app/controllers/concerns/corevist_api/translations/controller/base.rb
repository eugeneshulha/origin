module CorevistAPI::Translations::Controller::Base
  extend ActiveSupport::Concern

  included do
    before_action :init_translations
  end

  def init_translations(user = CorevistAPI::Context.current_user)
    return unless user.present?

    FastGettext.reload!
    set_user_language
    set_translations_params(user)
  end

  def set_translations_params(user)
    CorevistAPI::Translation.init(user.microsite, request.path)
  end

  def set_user_language
    user_language = params[:language].presence || CorevistAPI::Context.current_user&.language ||
                    FastGettext.default_locale

    FastGettext.locale = user_language
    CorevistAPI::Context[:lang] = user_language
  end
end
