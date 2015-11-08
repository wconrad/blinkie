module Blinkie
  module Drawing
    module Layout

      class Horizontal

        extend Forwardable

        def initialize(elements = [])
          @elements = elements
        end

        def update
          @elements.each(&:update)
        end

        def draw(left, top)
          @elements.each do |element|
            element.draw(left, top)
            left += element.width
          end
        end

        def width
          @elements.map(&:width).inject(0, &:+)
        end

        def height
          @elements.max(&:height)
        end

      end

    end
  end
end
