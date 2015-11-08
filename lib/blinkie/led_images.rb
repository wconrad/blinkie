require "rmagick"

require_relative "drawing/rmagic_image"

module Blinkie

  class LedImages

    def initialize
      @selectable = {
        false => circle(LED_OFF_COLOR),
        true => circle(LED_ON_COLOR),
      }
    end

    def to_hash
      @selectable
    end

    def width
      @selectable.width
    end

    def height
      @selectable.height
    end

    def draw(left, top, on)
      @selectable.select(!!on)
      @selectable.draw(left, top)
    end

    private

    LED_OFF_COLOR = "#440000"
    LED_ON_COLOR = "#aa3300"
    DIAMETER = 32
    RADIUS = DIAMETER / 2

    def circle(color)
      Drawing::RmagickImage.new(rmagick_circle(color))
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
