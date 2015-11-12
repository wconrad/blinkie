require "gosu"

require_relative "led_images"
require_relative "led_register"
require_relative "momentary_switch"
require_relative "switch_images"
require_relative "toggle_switch"
require_relative "toggle_switch_register"

module Blinkie

  class MainWindow < Gosu::Window

    def initialize
      super 640, 480
      self.caption = "Gosu Tutorial Game"
      num_leds = 8
      led_images = LedImages.new
      switch_images = SwitchImages.new
      switch_register = ToggleSwitchRegister.new(images: switch_images, bits: 8)
      @top_element = Drawing::Layout::Vertical.new
      led_register = LedRegister.new(images: led_images, bits: 8) do
        @count
      end
      @top_element << Drawing::Layout::Horizontal.new(
        led_register.map do |led|
          Drawing::Layout::Padding.new(led, padding: 4)
        end
      )
      switch_row = Drawing::Layout::Horizontal.new
      switch_register.each do |switch|
        switch_row << Drawing::Layout::Padding.new(switch, padding: 4)
      end
      switch_row << Drawing::Layout::Padding.new(
        MomentarySwitch.new(switch_images) do |on|
          @count = switch_register.value if on
        end,
        padding: 4
      )
      @top_element << switch_row
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
        try_mouse_event(:left_down)
      end
    end

    def button_up(id)
      case id
      when Gosu::MsLeft
        try_mouse_event(:left_up)
      end
    end

    def try_mouse_event(event)
      @top_element.try_mouse_event(mouse_x, mouse_y, event)
    end
    
  end

end
