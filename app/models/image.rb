class Image
  include Mongoid::Document

  mount_uploader :image, ImageUploader

  field :requested_dimensions, type: Hash, default: { width: nil, height: nil }
  field :current_dimensions, type: Hash, default: { width: nil, height: nil }
  field :image

  embedded_in :user

  validate :dimensions_validate

  private

  def dimensions_validate
    [:requested_dimensions, :current_dimensions].each do |dimensions|
      errors.add(dimensions, "width can't be blank") if public_send(dimensions)[:width].nil?
      errors.add(dimensions, "height can't be blank") if public_send(dimensions)[:height].nil?

      errors.add(dimensions, 'width must be greater than 0') if public_send(dimensions)[:width].to_i <= 0
      errors.add(dimensions, 'height must be greater than 0') if public_send(dimensions)[:height].to_i <= 0
    end
  end
end
