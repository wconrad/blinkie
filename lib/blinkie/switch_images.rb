require "rmagick"

require_relative "drawing/rmagic_image"

module Blinkie

  class SwitchImages

    def initialize
      @images = Hash[
        [false, true].map do |invert|
          [invert, draw(invert)]
        end
      ]
    end

    def to_hash
      @images
    end

    private

    DEPRESSED_COLOR = "#ffffff"
    ELEVATED_COLOR = "#aaaaaa"
    SHADOW_COLOR = "#bbbbbb"
    OUTLINE_COLOR = "#000000"
    WIDTH = 16
    HEIGHT = 32
    SHADOW_HEIGHT = 4

    def draw(invert)
      image = Magick::Image.new(WIDTH, HEIGHT) do
        self.background_color = "none"
      end
      gc = Magick::Draw.new
      top = 0
      [
        [SHADOW_HEIGHT, SHADOW_COLOR],
        [HEIGHT / 2 - SHADOW_HEIGHT, ELEVATED_COLOR],
        [HEIGHT / 2, DEPRESSED_COLOR],
      ].each do |height, color|
        bottom = top + height
        gc.fill_color(color)
        gc.rectangle(0, top, WIDTH, bottom)
        top = bottom
      end
      gc.fill("transparent")
      gc.stroke(OUTLINE_COLOR)
      gc.rectangle(0, 0, WIDTH - 1, HEIGHT - 1)
      gc.draw(image)
      image.flip! if invert
      Drawing::RmagickImage.new(image)
    end
    
  end

end
