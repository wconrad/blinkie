require "gosu"

require_relative "draws_image"

module Blinkie
  module Drawing
    
    class Image

      include DrawsImage

      # image is either an RMagic::Image, or the path to an image file.
      def initialize(image)
        @image = Gosu::Image.new(image)
      end

    end

  end
end
