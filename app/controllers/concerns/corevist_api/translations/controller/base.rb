module CorevistAPI::Translations::Controller::Base
  extend ActiveSupport::Concern

  included do
    before_action :init_translations
    # after_action :before_response
  end

  # init translations variable and load to cache translation for the user and his locale and micorsite
  def init_translations(user = CorevistAPI::Context.current_user)
    return unless user.present?

    set_user_language
    set_translations_params(user)
    # cache should be synced between unicorn's workers, thats why
    # decided to use cache hash code
    # for understanding if cache was changed in one of the workers
    # and should be reloaded in the others
    # TODO: Deal with cache and session replacement
    # cache_was_changed = session[:translations_cache_digest] != Translation.cache_digest
    #
    # if !Translation.cached?
    #   Translation.init_cache
    # elsif cache_was_changed
    #   Translation.reload_cache
    # end
  end

  def set_translations_params(user)
    CorevistAPI::Translation.init(user.microsite, request.path)
  end

  def set_user_language
    # determine the language
    user_language = params[:language].presence || CorevistAPI::Context.current_user&.language ||
                    FastGettext.default_locale

    # initialize FastGetText with the user's language
    FastGettext.locale = user_language # set language for the current request
    CorevistAPI::Context[:lang] = user_language
  end

  def before_response
    save_translations_digest
    store_used_translations
  end

  def save_translations_digest
    session[:translations_cache_digest] = Translation.cache_digest
  end

  def store_used_translations
    return if current_user.blank?
    return unless current_user.is_b2b?

    if session[:used_translations].present?
      session[:used_translations].merge!(Translation.used_translations)
    else
      session[:used_translations] = Translation.used_translations
    end
  end
end
