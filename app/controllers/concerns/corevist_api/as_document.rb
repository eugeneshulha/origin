module CorevistAPI
  module AsDocument
    extend ActiveSupport::Concern

    included do

      before_action :dispatch_object

      def new
        name = "show_#{@obj.model_name.element}"
        @result = service_for(:page_configs_read, name).call
      end

      def index
        @result =
            if request.get?
              name = "#{@obj.model_name.element}_list"
              service_for(:page_configs_read, name).call
            else
              form = form_for(@obj.api_names[:list], params)
              service = service_for(@obj.api_names[:list], form, params)
              service.call
            end
      end

      def show
        service = service_for(@obj.api_names[:display], @obj, params)
        @result = service.call
      end

      private

      def dispatch_object
        @obj = ('CorevistAPI::' + controller_name.singularize.capitalize).safe_constantize.new
      end
    end
  end
end
