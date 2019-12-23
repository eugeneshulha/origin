require 'devise'
require 'devise/jwt'

module CorevistAPI
  class Engine < ::Rails::Engine
    isolate_namespace CorevistAPI
  end
end
