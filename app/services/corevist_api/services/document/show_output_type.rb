module CorevistAPI
  module Services::Document
    class ShowOutputType < CorevistAPI::Services::BaseServiceWithForm

      private

      def perform
        @rfc_result = rfc_service_for(:salesdoc_display, @object, @params).call

        salesdoc = builder_for(:salesdoc, @rfc_result.data).build do |builder|
          builder.with_header
          builder.with_configs
          builder.with_items
          builder.with_prices
          builder.with_partners
        end

        @rfc_result = rfc_service_for(:get_pdf, salesdoc, @params).call

        result(@rfc_result.data[:pdf])
      end

      def doc_name
        @params[:controller]
            .gsub('corevist_api/api/v1/', '')
            .gsub('/output_types', '')
      end

      def obj
        @params[:controller]
            .gsub('/api/v1/', '::_')
            .gsub('/output_types', '')
            .singularize
            .camelize
            .constantize
            .new
      end
    end
  end
end
