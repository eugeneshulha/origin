class CorevistAPI::Translations::Fetchers::Base
  include Singleton

  def call(key)
    raise NotImplementedError
  end
end
