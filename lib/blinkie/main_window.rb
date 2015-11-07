require "gosu"

require_relative "horizontal_layout"
require_relative "led"
require_relative "led_images"

module Blinkie

  class MainWindow < Gosu::Window

    LED_OFF_COLOR = "#440000"
    LED_ON_COLOR = "#aa3300"

    def initialize
      super 640, 480
      self.caption = "Gosu Tutorial Game"
      num_leds = 8
      led_images = LedImages.new
      @leds = HorizontalLayout.new(
        (num_leds - 1).downto(0).map do |i|
          source = -> do
            bit = (@count >> i) & 1
            bit != 0
          end
          Led.new(led_images, source: source)
        end
      )
      @count = 123
      Thread.new do
        loop do
          @count += 1
          sleep(0.1)
        end
      end
    end

    def needs_cursor?
      true
    end

    def update
    end

    def draw
      draw_background
      @leds.update
      @leds.draw(0, 0)
    end

    BACKGROUND_COLOR = 0xff_666666

    def draw_background
      color = Gosu::Color.argb(BACKGROUND_COLOR)
      Gosu.draw_rect(0, 0, width, height, color)
    end

    def draw_rect(x1, y1, x2, y2, color)
      draw_quad(
        0, 0, color,
        width, 0, color,
        0, height, color,
        width, height, color,
        0,
      )
    end
    
    def button_down(id)
      if id == Gosu::KbQ
        close
      end
    end
    
  end

end
