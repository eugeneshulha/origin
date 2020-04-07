module CorevistAPI
  module Printable
    extend ActiveSupport::Concern

    included do

      before_action :dispatch_object
      before_action :prepare_params

      form_performer_for :index

      def show
        form = form_for(:show_output_type, params)
        service = service_for(:show_output_type, form, params)
        @result = service.call

        file = File.new('data.pdf', 'wb')
        file.write(@result.data)
        file.close

        send_file file.path, type: 'application/pdf', disposition: 'attachment'
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

      def performer_name
        'output_types_index'
      end
    end
  end
end
