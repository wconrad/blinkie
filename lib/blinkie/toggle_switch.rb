require "forwardable"

require_relative "drawing"
require_relative "switch_images"

module Blinkie

  class ToggleSwitch

    extend Forwardable
    include Drawing::IsVisualElement

    attr_reader :on

    def initialize(switch_images, on: false, &on_change)
      @layout = Drawing::Layout::Selectable.new(switch_images)
      @on = on
      @on_change = on_change || DO_NOTHING
      changed
    end

    def_delegators :@layout,
                   :draw,
                   :width,
                   :height,
                   :update

    def mouse_event(x, y, event)
      return unless event == :left_down
      @on = !@on
      changed
    end

    private

    DO_NOTHING = ->(*) {}

    def changed
      @layout.select(@on)
      @on_change.call(@on)
    end

  end

end
