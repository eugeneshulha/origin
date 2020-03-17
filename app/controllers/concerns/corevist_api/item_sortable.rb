module CorevistAPI
  module ItemSortable
    extend ActiveSupport::Concern

    included do

      before_action :dispatch_object
      before_action :prepare_params

      def index
        form = form_for(@obj.api_names[:sort_items], params)
        service = service_for(@obj.api_names[:sort_items], form, params)
        @result = service.call
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
                   .gsub('ItemsController', '')
                   .tr('::', '')
                   .singularize
                   .capitalize

        @obj = ('CorevistAPI::' + name).safe_constantize.new
      end
    end
  end
end
