require "gosu"

require_relative "is_visual_element"

module Blinkie
  module Drawing
    
    # A "null" drawable element.
    class Nothing
      include IsVisualElement
    end

  end
end
