module CorevistAPI::Services::Admin::Roles
  class ShowService < CorevistAPI::Services::Base::ShowService
    private

    def object_class
      CorevistAPI::Role
    end
  end
end
