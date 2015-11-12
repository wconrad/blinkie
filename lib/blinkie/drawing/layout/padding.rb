require "forwardable"

require_relative "../is_visual_element"

module Blinkie
  module Drawing
    module Layout

      #todo move this out of padding?
      class Padding

        extend Forwardable
        include IsVisualElement

        def initialize(
              element,
              padding: 0,
              vpadding: padding,
              hpadding: padding,
              left_padding: hpadding,
              right_padding: hpadding,
              top_padding: vpadding,
              bottom_padding: vpadding
            )
          @element = element
          @left_padding = left_padding || padding
          @right_padding = right_padding || padding
          @top_padding = top_padding || padding
          @bottom_padding = bottom_padding || padding
        end

        def_delegators :@element,
                       :mouse_event,
                       :update

        def draw(left, top)
          @element.draw(left + @left_padding, top + @top_padding)
        end

        def width
          @element.width + @left_padding + @right_padding
        end

        def height
          @element.height + @top_padding + @bottom_padding
        end

      end

    end
  end
end
