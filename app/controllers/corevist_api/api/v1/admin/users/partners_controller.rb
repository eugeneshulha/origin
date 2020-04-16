module CorevistAPI
  module API::V1::Admin
    class Users::PartnersController < BaseController
      form_performer_for :index, :destroy
    end
  end
end
