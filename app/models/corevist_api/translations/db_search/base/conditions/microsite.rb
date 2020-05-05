class CorevistAPI::Translations::DbSearch::Base::Conditions::Microsite < CorevistAPI::Translations::DbSearch::Base::Conditions::Base
  def initialize
    super
    @fetch_method = :by_microsite
  end

  def call(translations)
    translations.find do |t|
      @extra_condition.call(t) &&
        t.microsite_id.present? &&
        t.microsite == CorevistAPI::Translation.microsite &&
        t.location_used.blank?
    end
  end
end
