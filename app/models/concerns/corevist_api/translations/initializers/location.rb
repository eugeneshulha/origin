class CorevistAPI::Translations::Initializers::Location < CorevistAPI::Translations::Initializers::Base
  def initialize
    super
    @fetch_method = :by_location
  end

  def init?(translation)
    @extra_condition.call(translation) &&
      translation.microsite.blank? &&
      translation.location_used.present?
  end
end
