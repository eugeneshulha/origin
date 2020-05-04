class CorevistAPI::Translations::Initializers::Microsite < CorevistAPI::Translations::Initializers::Base
  def initialize
    super
    @fetch_method = :by_microsite
  end

  def init?(translation)
    @extra_condition.call(translation) &&
      translation.microsite.present? &&
      translation.location_used.blank?
  end
end
