class Image
  include Mongoid::Document

  attr_accessor :resize_width, :resize_height

  mount_uploader :image, ImageUploader

  field :requested_dimensions, type: Hash, default: { width: nil, height: nil }
  field :current_dimensions, type: Hash, default: { width: nil, height: nil }
  field :image

  embedded_in :user

  validates :image, presence: true

  validate :dimensions_validate

  before_validation :update_vals, on: [:create, :update]

  def resize!(params)
    self.resize_width = params[:resize_width]
    self.resize_height = params[:resize_height]
    save!
    image.recreate_versions!
    save!
    self
  end

  private

  def update_vals
    self.requested_dimensions = {
      width: resize_width.to_i,
      height: resize_height.to_i
    }
  end

  def dimensions_validate
    [:requested_dimensions, :current_dimensions].each do |dimensions|
      errors.add(dimensions, 'width must be greater than 0') if public_send(dimensions)[:width].to_i <= 0
      errors.add(dimensions, 'height must be greater than 0') if public_send(dimensions)[:height].to_i <= 0
    end
  end
end
