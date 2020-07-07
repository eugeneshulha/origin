module CorevistAPI::Services::Accounts
  class ShowService < CorevistAPI::Services::BaseService
    private

    def perform
      user = CorevistAPI::User.find_by(uuid: @params[:uuid])
      raise CorevistAPI::ServiceException.new(_('error|user not found')) unless user

      result(user)
    end
  end
end
