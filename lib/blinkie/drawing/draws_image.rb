require_relative "is_visual_element"

module Blinkie
  module Drawing

    module DrawsImage

      include IsVisualElement
      
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
