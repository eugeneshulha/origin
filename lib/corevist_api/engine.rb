require 'devise'
require 'devise/jwt'

module CorevistAPI
  class Engine < ::Rails::Engine
    isolate_namespace CorevistAPI

    config.railties_order = [CorevistAPI::Engine, :main_app, :all]
  end
end
