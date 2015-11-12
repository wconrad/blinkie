require_relative "../is_visual_element"

module Blinkie
  module Drawing
    module Layout

      class Vertical

        extend Forwardable
        include IsVisualElement

        def initialize(elements = [])
          @elements = elements
        end

        def <<(element)
          @elements << element
        end

        def update
          @elements.each(&:update)
        end

        def draw(left, top)
          @elements.each do |element|
            element.draw(left, top)
            top += element.height
          end
        end

        def width
          @elements.map(&:width).max
        end

        def height
          @elements.map(&:height).inject(0, &:+)
        end

        def mouse_event(x, y, event)
          @elements.each do |element|
            return true if element.try_mouse_event(x, y, event)
            y -= element.height
          end
          false
        end

      end

    end
  end
end
