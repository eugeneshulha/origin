module CorevistAPI
  module AsDocument
    extend ActiveSupport::Concern

    included do

      before_action :dispatch_object

      def index
        form = Factories::FormsFactory.instance.for(@obj.api_names[:list], params)
        service = Factories::ServicesFactory.instance.for(@obj.api_names[:list], form)
        @result = service.call
      end

      def show
        service = Factories::ServicesFactory.instance.for(@obj.api_names[:display], @obj, params)
        @result = service.call
      end

      private

      def dispatch_object
        @obj = ('CorevistAPI::' + controller_name.singularize.capitalize).safe_constantize.new
      end
    end
  end
end
