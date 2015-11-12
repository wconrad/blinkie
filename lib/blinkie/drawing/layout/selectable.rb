require "forwardable"

require_relative "../is_visual_element"

module Blinkie
  module Drawing
    module Layout
      
      class Selectable

        extend Forwardable
        include IsVisualElement

        def initialize(element_hash)
          @element_hash = Hash(element_hash)
        end

        def select(key)
          @key = key
        end

        def_delegators :selected_element,
                       :draw,
                       :try_mouse_event,
                       :update,
                       :width,
                       :height

        private

        def selected_element
          @element_hash.fetch(@key)
        end

      end

    end
  end
end
