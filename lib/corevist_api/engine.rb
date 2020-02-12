module CorevistAPI
  class Engine < ::Rails::Engine
    isolate_namespace CorevistAPI

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
  end
end
