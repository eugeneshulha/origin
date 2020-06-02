module CorevistAPI::Services::Admin::Users
  class StepsService < CorevistAPI::Services::BaseService
    KEY_FUNCTION = 'function'.freeze
    SERVICE_MAP = {
      AG: 4,
      WE: 5
    }.freeze

    def call
      result_steps = []

      result_steps << 2 if @params[:role_ids].present?
      result_steps << 3 if @params[:assignable_role_ids].present?
      result_steps << 6 if @params[:territories_ids].present?

      if (partners = @params[:partners]).present?
        partner_functions = partners.map { |partner| partner[KEY_FUNCTION].upcase.to_sym }.uniq
        raise CorevistAPI::ServiceException.new("api.#{namespace}.one_function") unless partner_functions.one?

        result_steps << SERVICE_MAP[partner_functions.first]
      end
      result(result_steps)
    end
  end
end
