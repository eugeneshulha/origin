module CorevistAPI
  module AsDocument
    extend ActiveSupport::Concern

    included do

      before_action :dispatch_object

      def index
        form = FormsFactory.instance.for(@obj.api_names[:search], params)
        service = ServicesFactory.instance.for(@obj.api_names[:search], form)
        @result = service.call
      end

      def show
        service = ServicesFactory.instance.for(@obj.api_names[:find], @obj, params)
        @result = service.call
      end

      private

      def dispatch_object
        @obj = ('CorevistAPI::' + controller_name.singularize.capitalize).safe_constantize.new
      end
    end
  end
end
