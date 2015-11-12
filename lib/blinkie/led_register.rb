require "forwardable"

require_relative "led"

module Blinkie

  class LedRegister

    extend Forwardable
    include Enumerable

    def initialize(led_images:, bits:, &register_source)
      @leds = (bits - 1).downto(0).map do |i|
        bit_source = -> do
          register_value = register_source.call
          bit = (register_value >> i) & 1
          bit != 0
        end
        Led.new(led_images, source: bit_source)
      end
    end

    def_delegator :@leds, :each

  end

end
