require "forwardable"

module Blinkie
  module Drawing
    module Layout
      
      class Selectable

        extend Forwardable

        def initialize(element_hash)
          @element_hash = Hash(element_hash)
        end

        def select(key)
          @key = key
        end

        def_delegators :selected_element,
                       :draw,
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
