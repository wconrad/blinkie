require "forwardable"

require_relative "switch"

module Blinkie

  class SwitchRegister

    extend Forwardable
    include Enumerable

    attr_reader :value

    def initialize(images:, bits:)
      @value = 0
      @switches = (bits - 1).downto(0).map do |bit_number|
        Switch.new(images) do |on|
          set_bit(bit_number, on)
        end
      end
    end

    def_delegator :@switches, :each

    private

    def set_bit(bit_number, on)
      bit = 1 << bit_number
      @value &= ~bit
      @value |= bit if on
      ql {@value} #DEBUG
    end

  end

end
