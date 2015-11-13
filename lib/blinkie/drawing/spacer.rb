require "gosu"

require_relative "is_visual_element"

module Blinkie
  module Drawing
    
    class Spacer
      
      include IsVisualElement

      attr_reader :width
      attr_reader :height

      def initialize(width: 0, height: 0)
        @width = width
        @height = height
      end

    end

  end
end
