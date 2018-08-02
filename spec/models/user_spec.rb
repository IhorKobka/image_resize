require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to embed_many(:images) }

  it { is_expected.to have_fields(:login, :password_digest) }

  it { is_expected.to validate_presence_of(:login) }
  it { is_expected.to validate_length_of(:login).with_maximum(25) }

  # https://github.com/mongoid/mongoid-rspec/issues/135
  it 'Expected User to have "length" validator on "password" with minimum of 6' do
    user = User.new(password: '123')
    user.valid?
    expect(user.errors[:password]).to include 'is too short (minimum is 6 characters)'
  end


end
