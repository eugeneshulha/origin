class CorevistAPI::Translations::Initializers::Locale < CorevistAPI::Translations::Initializers::Base
  def initialize
    super
    @fetch_method = :by_locale
  end

  def init?(translation)
    @extra_condition.call(translation) &&
      translation.microsite.blank? &&
      translation.location_used.blank?
  end
end
