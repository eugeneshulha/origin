module CorevistAPI::Translations::DbSearch::Base
  private

  # base implementation of method for translation search in database
  def db_search(translations)
    result = nil

    conditions.each do |c|
      result = c.call(translations)
      break if result.present?
    end

    result
  end

  # returns default translation for the key and locale
  def default(key)
    where(default_query(key)).first
  end

  def conditions
    @conditions ||= [
      Conditions::Microsite.instance,
      Conditions::Locale.instance,
      Conditions::LocationMicrosite.instance,
      Conditions::Location.instance
    ]
  end
end
