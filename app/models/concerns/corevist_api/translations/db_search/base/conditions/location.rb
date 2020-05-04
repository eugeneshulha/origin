class CorevistAPI::Translations::DbSearch::Base::Conditions::Location < CorevistAPI::Translations::DbSearch::Base::Conditions::Base
  def initialize
    super
    @fetch_method = :by_location
  end

  def call(translations)
    translations.find do |t|
      @extra_condition.call(t) &&
        t.microsite_id.blank? &&
        t.location_used.present? &&
        t.location_used == CorevistAPI::Translation.location
    end
  end
end
