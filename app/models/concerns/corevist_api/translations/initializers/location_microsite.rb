class CorevistAPI::Translations::Initializers::LocationMicrosite < CorevistAPI::Translations::Initializers::Base
  def initialize
    super
    @fetch_method = :by_location_and_microsite
  end

  def init?(translation)
    @extra_condition.call(translation) &&
      translation.microsite.present? &&
      translation.location_used.present?
  end
end
