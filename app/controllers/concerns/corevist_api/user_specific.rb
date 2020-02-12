module CorevistAPI
  module UserSpecific
    extend ActiveSupport::Concern

    included do
      before_action :find_user
    end

    def find_user
      return error('api.errors.user_not_found') unless (user = User.find_by_uuid(params[:user_uuid]))

      @user = authorize(user)
    end
  end
end
