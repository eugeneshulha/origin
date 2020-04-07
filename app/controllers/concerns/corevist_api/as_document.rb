module CorevistAPI
  module AsDocument
    extend ActiveSupport::Concern

    included do
      before_action :dispatch_object

      form_performer_for :index
      obj_performer_for :show
      configs_for :new, :index

      private

      def dispatch_object
        @obj = ('CorevistAPI::' + controller_name.singularize.capitalize).safe_constantize.new
      end
    end
  end
end
