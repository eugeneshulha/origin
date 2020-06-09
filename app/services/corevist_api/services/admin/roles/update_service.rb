module CorevistAPI::Services::Admin::Roles
  class UpdateService < CorevistAPI::Services::Base::UpdateService
    private

    def object_class
      CorevistAPI::Role
    end
  end
end
