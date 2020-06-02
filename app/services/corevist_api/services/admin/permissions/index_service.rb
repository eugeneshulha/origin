module CorevistAPI::Services::Admin::Permissions
  class IndexService < CorevistAPI::Services::Base::IndexService
    private

    def filter
      result(CorevistAPI::Permission.all)
    end
  end
end
