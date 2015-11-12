require "forwardable"

require_relative "toggle_switch"

module Blinkie

  class ToggleSwitchRegister

    extend Forwardable
    include Enumerable

    attr_reader :value

    def initialize(images:, bits:)
      @value = 0
      @switches = (bits - 1).downto(0).map do |bit_number|
        ToggleSwitch.new(images) do |on|
          set_bit(bit_number, on)
        end
      end
    end

    def_delegator :@switches, :each

    private

    def set_bit(bit_number, on)
      bit = 1 << bit_number
      if on
        @value |= bit
      else
        @value &= ~bit
      end
    end

  end

end
