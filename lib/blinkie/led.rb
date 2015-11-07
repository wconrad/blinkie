require_relative "led_images"

module Blinkie

  class Led

    attr_accessor :source

    def initialize(led_images, source: -> { false })
      @led_images = led_images
      @source = source
    end

    def update
      @on = @source.call
    end

    def draw(left, top)
      @led_images.draw(left, top, @on)
    end

    def width
      LedImages::WIDTH
    end

    def height
      LedImages::HEIGHT
    end

  end

end
