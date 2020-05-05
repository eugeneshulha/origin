module CorevistAPI::Translations::DbSearch::Base
  private

  # base implementation of method for translation search in database
  def db_search(translations)
    conditions.each do |c|
      result = c.call(translations)
      return result if result.present?
    end
    nil
  end

  # returns default translation for the key and locale
  def default(key)
    where(default_query(key)).first
  end

  def conditions
    @conditions ||= [
      CorevistAPI::Translations::DbSearch::Base::Conditions::Microsite.instance,
      CorevistAPI::Translations::DbSearch::Base::Conditions::Locale.instance,
      CorevistAPI::Translations::DbSearch::Base::Conditions::LocationMicrosite.instance,
      CorevistAPI::Translations::DbSearch::Base::Conditions::Location.instance
    ]
  end
end
