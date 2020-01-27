module CorevistAPI
  module Services::Salesdoc
    class Display < CorevistAPI::BaseService

      def call
        perform!
      end

      private

      def perform!
        RFCServicesFactory.instance.for(:find_salesdoc, @object, :get_salesdoc, @params)
      end
    end
  end
end
