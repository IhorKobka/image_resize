require 'rails_helper'

RSpec.describe Image, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to be_embedded_in(:user) }

  it { is_expected.to have_field(:image) }
  it { is_expected.to have_field(:requested_dimensions).of_type(Hash)
                        .with_default_value_of({ width: nil, height: nil }) }
  it { is_expected.to have_field(:current_dimensions).of_type(Hash)
                        .with_default_value_of({ width: nil, height: nil }) }

  it { is_expected.to validate_presence_of(:image) }

  it 'Validate dimensions' do
    image = Image.new
    image.valid?

    [:requested_dimensions, :current_dimensions].each do |k|
      expect(image.errors[k]).to include 'width must be greater than 0', 'height must be greater than 0'
    end
  end


  describe '#resize!' do
    before(:each) do
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end

    it 'resize image' do
      image = create(:user, with_image: true).images.first
      image.resize!(resize_width: 100, resize_height: 100)
      expect(image[:requested_dimensions]).to eq({ width: 100, height: 100 })
    end
  end
end
