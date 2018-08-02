module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request

      def create
        token = AuthUser.new(*auth_params.values).auth
        json_response({ token: token })
      end

      private

      def auth_params
        params.require(:user).permit(:login, :password)
      end
    end
  end
end

