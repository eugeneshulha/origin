module CorevistAPI
  module UserSpecific
    extend ActiveSupport::Concern

    included do
      before_action :find_user
    end

    def find_user
      return error('api.errors.user_not_found') unless (user = User.find_by(uuid: params[:user_id]))

      @user = authorize(user)
    end
  end
end
