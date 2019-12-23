module CorevistAPI
  class Api::V1::Admin::ApplicationController < ApplicationController
    before_action :authenticate_admin!


    private

      def authenticate_admin!
      end
  end
end
