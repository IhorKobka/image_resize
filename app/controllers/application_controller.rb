class ApplicationController < ActionController::API
  include JsonResponseable
  include ExceptionHandler

  before_action :authenticate_request

  attr_reader :current_user

  protected

  def authenticate_request
    @current_user = AuthRequest.new(request.headers).auth
  end
end
