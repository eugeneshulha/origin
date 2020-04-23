require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "corevist_api"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.secret_key_base = '2c4adbadd9c8ca85fc18e8cf6917ce7f106441b98634586b79f048a039e2c1694f357a0eba4c4f71e4cf2519'\
    '42a2fa5f541f62ae6ded404412d6b68f81ff6d4f8bdf373b2756559bd86020824b15358039e7d4902432584fa1f86cb7800f08f01062f3575'\
    '5276158ef036ce68846a5b953b581e4629634d810ac3c4958b3fcaa'


    # Rack CORS configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'

        resource '*',
                 headers: :any,
                 methods: [:get, :post, :put, :patch, :delete, :options, :head],
                 expose: %w(Access-Control-Allow-Origin Authorization HTTP_AUTHORIZATION)
      end
    end

    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => '*'
    }

    config.paths['config/database'] = "#{CorevistAPI::Engine.root}/spec/dummy/config/database.yml"
  end
end

