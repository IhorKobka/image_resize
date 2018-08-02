FactoryBot.define do
  factory :user do
    login 'test'
    password '1234567890'

    transient do
      with_image false
    end

    after(:create) do |user, evaluator|
      user.images.create(
        resize_width: 1000,
        resize_height: 1000,
        image: Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.jpg'), 'image/jpeg')
      ) if evaluator.with_image
    end
  end
end
