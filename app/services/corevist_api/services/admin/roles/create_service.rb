module CorevistAPI::Services::Admin::Roles
  class CreateService < CorevistAPI::Services::Base::CreateService
    private

    def object_class
      CorevistAPI::Role
    end
  end
end
