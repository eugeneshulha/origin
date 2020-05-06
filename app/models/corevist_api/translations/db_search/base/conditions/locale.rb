class CorevistAPI::Translations::DbSearch::Base::Conditions::Locale < CorevistAPI::Translations::DbSearch::Base::Conditions::Base
  def initialize
    super
    @fetch_method = :by_locale
  end

  def call(translations)
    translations.find do |t|
      @extra_condition.call(t) &&
        t.microsite_id.blank? &&
        t.location_used.blank?
    end
  end
end
