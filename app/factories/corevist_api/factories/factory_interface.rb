module CorevistAPI
  module Factories
    module FactoryInterface
      def builder_for(type, *args)
        CorevistAPI::Factories::BuildersFactory.instance.for(type, *args)
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

      def validation_for(attribute, validation)
        CorevistAPI::Factories::ValidationsFactory.instance.for(attribute, validation)
      end

      def download_manager_for(attribute, *args)
        CorevistAPI::Factories::DownloadManagersFactory.instance.for(attribute, *args)
      end
    end
  end
end
