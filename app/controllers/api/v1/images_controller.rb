module Api
  module V1
    class ImagesController < ApplicationController
      def index
        json_response(current_user.images)
      end

      def create
        json_response(current_user.images.create!(image_params))
      end

      def update
        image = current_user.images.find(params[:id])
        json_response(image.resize!(image_resize_params))
      end

      private

      def image_resize_params
        params.require(:image).permit(:resize_width, :resize_height)
      end

      def image_params
        params.require(:image).permit(:resize_width, :resize_height, :image)
      end
    end
  end
end

