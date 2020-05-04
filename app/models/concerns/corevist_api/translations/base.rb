module CorevistAPI::Translations::Base
  def self.load
    require 'translations/fastgettext/initializer'
    require 'translations/fastgettext/patch'
    require 'get_pomo'

    # ActiveSupport.on_load(:action_view) do
    #   include Translations::View::Helper
    # end
  end
end
