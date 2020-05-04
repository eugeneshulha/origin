class CorevistAPI::Translations::Initializers::Base
  include Singleton
  attr_reader :fetch_method
  attr_accessor :extra_condition

  def initialize
    @extra_condition = -> (t) { true }
    @fetch_method = nil
  end

  def init?(translation)
    raise NotImplementedError
  end
end
