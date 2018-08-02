require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe 'POST /auth' do
    it 'returns jwt token' do
      user = create(:user)
      post api_v1_auth_path, params: { user: { login: user.login, password: user.password } }
      expect(response).to have_http_status(200)
      expect(response.body['token']).to_not be_nil
    end
  end
end
