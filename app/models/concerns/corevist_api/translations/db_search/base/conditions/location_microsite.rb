class CorevistAPI::Translations::DbSearch::Base::Conditions::LocationMicrosite < CorevistAPI::Translations::DbSearch::Base::Conditions::Base
  def initialize
    super
    @fetch_method = :by_location_and_microsite
  end

  def call(translations)
    translations.find do |t|
      @extra_condition.call(t) &&
        t.microsite_id.present? &&
        t.microsite_id == CorevistAPI::Translation.microsite_id &&
        t.location_used.present? &&
        t.location_used == CorevistAPI::Translation.location
    end
  end
end
