require "forwardable"

require_relative "drawing"
require_relative "led"

module Blinkie

  class Register

    extend Forwardable

    def initialize(led_images:, bits:, &register_source)
      @leds = Drawing::Layout::Horizontal.new(
        (bits - 1).downto(0).map do |i|
          bit_source = -> do
            register_value = register_source.call
            bit = (register_value >> i) & 1
            bit != 0
          end
          Drawing::Layout::Padding.new(
            Led.new(led_images, source: bit_source),
            padding: 10
          )
        end
      )
    end

    def_delegators :"@leds",
       :update,
       :draw,
       :width,
       :height

  end

end
