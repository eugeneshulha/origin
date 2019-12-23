module CorevistAPI
  class Api::V1::ApplicationController < ApplicationController
    before_action :authenticate_user!

    private

      def authenticate_user!
      end
  end
end
