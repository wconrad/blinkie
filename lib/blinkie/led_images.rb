require "gosu"
require "rmagick"

module Blinkie

  class LedImages

    WIDTH = HEIGHT = 32
    LED_OFF_COLOR = "#440000"
    LED_ON_COLOR = "#aa3300"

    def initialize
      @on = circle(LED_ON_COLOR)
      @off = circle(LED_OFF_COLOR)
    end

    def draw(left, top, on)
      image = image(on)
      z = 0
      scale = 1
      image.draw(left, top, z, scale, scale)
    end

    private

    def image(on)
      if on
        @on
      else
        @off
      end
    end

    def circle(color)
      Gosu::Image.new(rmagick_circle(color))
    end

    def rmagick_circle(color)
      image = Magick::Image.new(WIDTH, HEIGHT) do
        self.background_color = "none"
      end
      gc = Magick::Draw.new
      origin_x = WIDTH / 2
      origin_y = HEIGHT / 2
      perim_x = WIDTH / 2
      perim_y = 1
      gc.fill_color(color)
      gc.circle(origin_x, origin_y, perim_x, perim_y)
      gc.draw(image)
      image
    end
    
  end

end
