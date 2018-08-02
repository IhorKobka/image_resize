module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found
    rescue_from Mongoid::Errors::Validations, with: :unprocessable_entity

    rescue_from Exception::Auth::InvalidCredentials, with: :unprocessable_entity
    rescue_from Exception::Auth::InvalidToken, with: :unauthorized_request
    rescue_from Exception::Auth::MissingToken, with: :unauthorized_request
  end

  private

  def unauthorized_request(e)
    json_response({ message: e.message }, status: :unauthorized)
  end

  def unprocessable_entity(e)
    json_response({ message: e.message }, status: :unprocessable_entity)
  end

  def not_found(e)
    json_response({ message: e.message }, status: :not_found)
  end
end
