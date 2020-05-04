class CorevistAPI::Translations::DbSearch::Base::Conditions::Base
  include Singleton
  attr_reader :fetch_method
  attr_accessor :extra_condition

  def initialize
    @extra_condition = ->(t) { true }
  end

  def call(translations)
    raise NotImplementedError
  end
end
