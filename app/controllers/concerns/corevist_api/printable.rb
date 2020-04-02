module CorevistAPI
  module Printable
    extend ActiveSupport::Concern

    included do

      before_action :dispatch_object
      before_action :prepare_params

      def index
        form = form_for(:output_types_list, params)
        service = service_for(:output_types_list, form, params)
        @result = service.call
      end

      def show
        form = form_for(:show_output_type, params)
        service = service_for(:show_output_type, form, params)
        @result = service.call

        # send_data @result.data, disposition: 'inline', type: 'application/pdf'
        file = File.new('data.pdf', 'wb')
        file.write(@result.data)
        file.close
        send_file file.path, type: 'application/pdf', disposition: 'attachment'

        # send_file File.new('blabla.pdf', 'w') { |x| x << @result.data }, type: 'application/pdf'
      end

      private

      def prepare_params
        if @obj.blank?
          Rails.logger.error("CorevistAPI::ItemSortable")
          Rails.logger.error(":prepare_params method, @obj was not set, self.class is #{self.class}")

          return error('api.errors.something_went_wrong')
        end

        params[:doc_number] = params["#{@obj.model_name.element}_doc_number"]
      end

      def dispatch_object
        name = self.class.to_s
                   .gsub('CorevistAPI::API::V1::', '')
                   .gsub('OutputTypesController', '')
                   .tr('::', '')
                   .singularize
                   .capitalize

        @obj = ('CorevistAPI::' + name).safe_constantize.new
      end
    end
  end
end
