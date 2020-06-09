module CorevistAPI
  class API::V1::Admin::SystemSettings::SalesAreasController < API::V1::Admin::BaseController
    form_performer_for :index, :create, :update
    obj_performer_for :show, :destroy
    configs_for :index, :edit, :new

    STEPS = %w[1 2 3].freeze

    private

    def performer_name
      return super if params[:step].blank?

      "#{action_prefix}_#{action_name}_step_#{params[:step]}".to_sym
    end

    def scope_model
      SalesArea
    end
  end
end
