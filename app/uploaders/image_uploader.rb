class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process :resize_image
  process :store_dimensions

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def resize_image
    dimensions = model.requested_dimensions
    resize_to_fit(dimensions[:width], dimensions[:height])
  end

  def store_dimensions
    if file && model
      dimensions = MiniMagick::Image.open(file.file)[:dimensions]
      model.current_dimensions[:width] = dimensions.first
      model.current_dimensions[:height] = dimensions.last
    end
  end
end
