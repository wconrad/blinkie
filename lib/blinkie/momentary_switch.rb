require "forwardable"
require_relative "drawing"
require_relative "switch_images"

module Blinkie

  class MomentarySwitch

    extend Forwardable
    include Drawing::IsVisualElement

    def initialize(switch_images, &on_change)
      @layout = Drawing::Layout::Selectable.new(switch_images)
      @on = false
      @on_change = on_change
      set_layout
    end

    def_delegators :@layout,
                   :draw,
                   :width,
                   :height,
                   :update

    def mouse_event(x, y, event)
      @on = event == :left_down
      changed
    end

    private

    def changed
      set_layout
      notify
    end

    def set_layout
      @layout.select(@on)
    end

    def notify
      @on_change.call(@on)
    end

  end

end
