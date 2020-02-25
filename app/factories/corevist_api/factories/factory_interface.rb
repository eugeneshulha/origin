module CorevistAPI
  module Factories
    module FactoryInterface
      def builder_for(type, *args)
        CorevistAPI::Factories::BuildersFactory.instance.for(type, *args)
      end

      def config_for(type, *args)
        CorevistAPI::Factories::ConfigsFactory.instance.for(type, *args)
      end

      def should_authorize_configs_for?(type)
        CorevistAPI::Factories::ConfigsFactory.instance.unauthorized_config?(type)
      end

      def form_for(type, *args)
        CorevistAPI::Factories::FormsFactory.instance.for(type, *args)
      end

      def service_for(type, *args)
        CorevistAPI::Factories::ServicesFactory.instance.for(type, *args)
      end

      def rfc_service_for(type, obj, args)
        CorevistAPI::Factories::RFCServicesFactory.instance.for(type, obj, *args)
      end
    end
  end
end
