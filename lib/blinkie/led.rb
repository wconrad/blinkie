require "forwardable"

require_relative "drawing/layout/selectable"
require_relative "led_images"

module Blinkie

  class Led

    extend Forwardable

    attr_accessor :source

    def initialize(led_images, source: -> { false })
      @layout = Drawing::Layout::Selectable.new(led_images)
      @source = source
    end

    def update
      on = !!@source.call
      @layout.select(on)
    end

    def_delegators :@layout,
                   :draw,
                   :width,
                   :height

  end

end
