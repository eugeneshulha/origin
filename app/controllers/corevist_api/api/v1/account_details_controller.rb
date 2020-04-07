module CorevistAPI
  class API::V1::AccountDetailsController < API::V1::BaseController
    include CorevistAPI::UserSpecific

    form_performer_for :show
  end
end
