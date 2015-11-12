require "forwardable"

require_relative "led"

module Blinkie

  class LedRegister

    extend Forwardable
    include Enumerable

    def initialize(images:, bits:, &register_source)
      @leds = (bits - 1).downto(0).map do |i|
        bit_source = -> do
          register_source.call[i] != 0
        end
        Led.new(images, source: bit_source)
      end
    end

    def_delegator :@leds, :each

  end

end
