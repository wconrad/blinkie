require_relative "../is_visual_element"

module Blinkie
  module Drawing
    module Layout

      class Horizontal

        extend Forwardable
        include IsVisualElement

        def initialize(elements = [])
          @elements = elements
        end

        def_delegator :@elements, :<<

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
          @elements.map(&:height).max
        end

        def mouse_event(x, y, event)
          @elements.each do |element|
            return true if element.try_mouse_event(x, y, event)
            x -= element.width
          end
          false
        end

      end

    end
  end
end
