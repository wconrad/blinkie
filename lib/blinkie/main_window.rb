require "gosu"

require_relative "led_images"
require_relative "register"
require_relative "switch"
require_relative "switch_images"

module Blinkie

  class MainWindow < Gosu::Window

    def initialize
      super 640, 480
      self.caption = "Gosu Tutorial Game"
      num_leds = 8
      led_images = LedImages.new
      switch_images = SwitchImages.new
      @top_element = Drawing::Layout::Vertical.new
      @top_element << Register.new(led_images: led_images, bits: 8) do
        @count
      end
      @top_element << Switch.new(switch_images) do |on|
        ql {on}
      end
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
      @top_element.update
    end

    def draw
      draw_background
      @top_element.draw(0, 0)
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
      case id
      when Gosu::KbQ
        close
      when Gosu::MsLeft
        @top_element.try_mouse_event(mouse_x, mouse_y, :left_click)
      end
    end
    
  end

end
