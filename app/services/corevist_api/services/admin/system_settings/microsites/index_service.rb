module CorevistAPI::Services::Admin::SystemSettings::Microsites
  class IndexService < CorevistAPI::Services::Base::IndexService
    private

    def filter
      result(CorevistAPI::Microsite.includes(:users).all)
    end
  end
end
