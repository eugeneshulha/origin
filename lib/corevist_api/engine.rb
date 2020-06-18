
module CorevistAPI
  class Engine < ::Rails::Engine
    isolate_namespace CorevistAPI
    engine_name 'corevist_api'

    include CorevistAPI::Factories::FactoryInterface

    config.railties_order = [CorevistAPI::Engine, :main_app, :all]
    config.active_job.queue_adapter = :sidekiq

    initializer :middleware do |app|
      app.middleware.use CorevistAPI::ContextManager
    end

    initializer 'corevist.assets.precompile' do |app|
      %w[stylesheets javascripts fonts images].each do |sub|
        app.config.assets.paths << File.join(CorevistAPI::Engine.root, 'vendor/assets/corevist_api/', sub, '/')
        app.config.assets.paths << File.join(CorevistAPI::Engine.root, 'app/assets/corevist_api/', sub, '/')
      end
    end

    initializer 'connect_to_sap' do
      service = service_for(:connect_to_sap)
      result = service.call
      CorevistAPI::Context.current_connection = result.data
    end

    initializer :translations do
      default_locales = %i[en_US de_DE fr_FR es_ES da_DK sv_SE nl_BE nl_NL ru_RU pt_BR zh_CN pt_PT pl_PL it_IT fr_CA]
      FastGettext.add_text_domain(:api, type: :db, model: CorevistAPI::Translation)
      FastGettext.default_available_locales = default_locales
      FastGettext.default_locale = :en_US
      FastGettext.default_text_domain = :api
      I18n.enforce_available_locales = false
    end
  end
end

