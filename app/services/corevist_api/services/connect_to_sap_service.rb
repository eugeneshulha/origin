module CorevistAPI:: Services
  class ConnectToSAPService < CorevistAPI::Services::BaseService
    def initialize(params = {})
      @params = params.dup
      @errors = []
    end

    def call
      connection_configs = CorevistAPI::SAPConnection.find_by(id: @params[:uuid]) if @params[:uuid]
      connection_configs ||= CorevistAPI::SAPConnection.current
      raise ServiceException(_('error|no configs found for connection')) unless connection_configs

      new_connection = CorevistAPI::RFCServices::BaseRFC::Connection.new(connection_configs&.connection_params)
      result(new_connection.open)
    end
  end
end
