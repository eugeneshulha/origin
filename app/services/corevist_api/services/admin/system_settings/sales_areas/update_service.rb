module CorevistAPI::Services::Admin::SystemSettings::SalesAreas
  class UpdateService < CorevistAPI::Services::Admin::SystemSettings::SalesAreas::Step1Service
    private

    STEPS = {
        doc_type_ids: 2,
        doc_category_ids: 3,
        microsite_ids: 4,
        title: 1,
        description: 1,
        active: 1
    }

    def perform
      ActiveRecord::Base.transaction do
        super

        steps = @params.keys.map {|x| STEPS[x.to_sym] }.compact
        steps.each_with_index do |step, index|
          type = "admin_system_settings_sales_areas_create_step_#{step}"
          form = form_for(type, @params)
          service_result = service_for(type, form, @params).call
          break service_result unless steps[index.next]
        end
      end
    end
  end
end
