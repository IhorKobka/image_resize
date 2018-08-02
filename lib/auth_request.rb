class AuthRequest
  def initialize(headers = {})
    @headers = headers
  end

  def auth
    user
  end

  private

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    return @user if @user
    raise Exception::Auth::InvalidToken
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    header = @headers['Authorization']
    return header.split(' ').last if header.present?

    raise Exception::Auth::MissingToken
  end
end