module CorevistAPI
  class API::V1::Admin::TranslationsController < API::V1::Admin::BaseController
    include CorevistAPI::Downloadable

    form_performer_for :index, :create, :update, :destroy
    configs_for :index, :new, :edit

    before_action :dispatch_object, only: :download
    skip_before_action :establish_sap_connection

    private

    def scope_model
      Translation
    end

    def dispatch_object
      @obj = CorevistAPI::Translation.new
    end
  end
end
