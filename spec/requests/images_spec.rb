require 'rails_helper'

RSpec.describe "Images", type: :request do
  describe 'GET /images' do
    it 'returns all user images' do
      user = create(:user, with_image: true)
      token = AuthUser.new(user.login, user.password).auth

      get api_v1_images_path, params: {}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(response.body).to include user.images.first.id.to_s
    end
  end

  describe 'POST /images' do
    it 'creates new user image' do
      user = create(:user)
      token = AuthUser.new(user.login, user.password).auth

      post api_v1_images_path,
           params: {
             image: {
               resize_width: 1000,
               resize_height: 1000,
               image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg')
             }
           },
           headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(response.body).to include user.reload.images.first.id.to_s
    end
  end

  describe 'PATCH /images' do
    it 'resize user image' do
      user = create(:user, with_image: true)
      token = AuthUser.new(user.login, user.password).auth

      patch api_v1_image_path(user.images.first),
           params: {
             image: {
               resize_width: 100,
               resize_height: 100,
             }
           },
           headers: { Authorization: "Bearer #{token}" }

      expect(response).to have_http_status(200)
      expect(response.body).to include user.images.first.id.to_s
    end
  end
end
