module CorevistAPI::Services::Accounts
  class ShowService < CorevistAPI::Services::BaseService

    def call
      perform
    end

    private

    def perform
      user = CorevistAPI::User.find_by(uuid: @params[:user_id])
      raise CorevistAPI::ServiceException.new(_('error|user not found')) unless user

      result(user)
    end
  end
end
