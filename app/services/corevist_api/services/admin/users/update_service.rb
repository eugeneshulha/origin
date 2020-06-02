module CorevistAPI::Services::Admin::Users
  class UpdateService < Step1CreationService
    private

    def perform
      ActiveRecord::Base.transaction do
        super
        steps = service_for(:admin_users_steps, nil, @params).call.data

        steps.each_with_index do |step, index|
          type = "admin_users_step_#{step}"
          form = form_for(type, @params)
          service_result = service_for(type, form, @params).call
          break service_result unless steps[index.next]
        end
      end
    end

    def obtain_object
      @id = @form.remove_instance_variable(:@id)
      CorevistAPI::User.find_by_id(@id)
    end
  end
end
