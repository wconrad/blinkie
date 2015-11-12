require "rmagick"

require_relative "drawing"

module Blinkie

  class LedImages

    def initialize
      @images = {
        false => circle(LED_OFF_COLOR),
        true => circle(LED_ON_COLOR),
      }
    end

    def to_hash
      @images
    end

    private

    LED_OFF_COLOR = "#440000"
    LED_ON_COLOR = "#aa3300"
    DIAMETER = 16
    RADIUS = DIAMETER / 2

    def circle(color)
      Drawing::Image.new(rmagick_circle(color))
    end

    def rmagick_circle(color)
      image = Magick::Image.new(DIAMETER, DIAMETER) do
        self.background_color = "none"
      end
      gc = Magick::Draw.new
      origin_x = RADIUS
      origin_y = RADIUS
      perim_x = RADIUS
      perim_y = 1
      gc.fill_color(color)
      gc.circle(origin_x, origin_y, perim_x, perim_y)
      gc.draw(image)
      image
    end
    
  end

end
