require "gosu"

require_relative "is_visual_element"

module Blinkie
  module Drawing
    
    # An image, from a file, or created by rmagick.
    class RmagickImage

      include IsVisualElement

      # image is either an RMagic::Image, or the path to an image file.
      def initialize(image)
        @image = Gosu::Image.new(image)
      end

      def width
        @image.columns
      end

      def height
        @image.rows
      end

      def draw(left, top)
        z = 0
        scale = 1
        @image.draw(left, top, z, scale, scale)
      end

    end

  end
end
