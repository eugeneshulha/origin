module CorevistAPI
  module Services
    module Admin::Users
      class DestroyService < Base::DestroyService
        private

        def object_class
          CorevistAPI::User
        end
      end
    end
  end
end
