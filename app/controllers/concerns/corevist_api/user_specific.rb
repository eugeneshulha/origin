module CorevistAPI
  module UserSpecific
    extend ActiveSupport::Concern

    included do
      before_action :find_user
    end

    def find_user
      return entry_not_found(:user) if (user = User.find_by_uuid(params[:user_uuid])).blank?

      @user = authorize(user)
    end
  end
end
