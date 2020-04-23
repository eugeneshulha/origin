module CorevistAPI
  class Translation < ApplicationRecord
    self.table_name = 'translations'

    def value
      cst_translation.nil? ? df_translation : cst_translation
    end

    def self.translation(key, locale = FastGettext.default_locale)
      where(key: key, microsite_id: CorevistAPI::Context.current_user&.microsite_id, locale: locale, active: true)
    end
  end
end
