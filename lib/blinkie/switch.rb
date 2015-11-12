require "forwardable"
require_relative "drawing"
require_relative "switch_images"

module Blinkie

  class Switch

    extend Forwardable
    include Drawing::IsVisualElement

    attr_accessor :source

    def initialize(switch_images, on: false, &on_change)
      @layout = Drawing::Layout::Selectable.new(switch_images)
      @on = on
      @on_change = on_change
      changed
    end

    def_delegators :@layout,
                   :draw,
                   :width,
                   :height,
                   :update

    def mouse_event(x, y, event)
      @on = !@on
      changed
    end

    private

    def changed
      @layout.select(@on)
      @on_change.call(@on)
    end

  end

end
