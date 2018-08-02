class AuthUser
  def initialize(login, password)
    @login = login
    @password = password
  end

  def auth
    JsonWebToken.encode(user_id: user.id.to_s)
  end

  private

  def user
    user = User.find_by(login: @login)
    p user
    return user if user&.authenticate(@password)

    raise Exception::Auth::InvalidCredentials
  end
end