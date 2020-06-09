module CorevistAPI::Services::Admin::Roles
  class DestroyService < CorevistAPI::Services::Base::DestroyService
    private

    def object_class
      CorevistAPI::Role
    end
  end
end
