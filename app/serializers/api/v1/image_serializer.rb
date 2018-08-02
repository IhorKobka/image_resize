module Api
  module V1
    class ImageSerializer < ActiveModel::Serializer
      attributes :id,
                 :requested_dimensions,
                 :current_dimensions,
                 :url

      def id
        object.id.to_s
      end

      def url
        object.image.url
      end
    end
  end
end

