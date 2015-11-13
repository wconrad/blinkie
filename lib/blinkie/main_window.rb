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
      super 300, 150
      self.caption = "Blinkie"
      Thread.abort_on_exception = true
      @count = 0
      @top_element = Drawing::Layout::Vertical.new
      @led_images = LedImages.new
      @switch_images = SwitchImages.new
      @switch_register = ToggleSwitchRegister.new(images: @switch_images, bits: NUM_LEDS)
      @reset_switch = MomentarySwitch.new(@switch_images) do |on|
        @count = @switch_register.value if on
      end
      @run_switch = ToggleSwitch.new(@switch_images, on: true)
      @led_register = LedRegister.new(images: @led_images, bits: NUM_LEDS) do
        @count
      end
      init_layout
      Thread.new do
        loop do
          @count += 1 if @run_switch.on
          sleep(0.5)
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

    private

    BACKGROUND_COLOR = 0xff_666666
    NUM_LEDS = 8

    #todo fine-tune text labels
    #todo better class for text
    def init_layout
      grid = Drawing::Layout::Grid.new
      row = @led_register.map do |led|
        Drawing::Padding.new(led, padding: 4)
      end
      grid << row
      row = NUM_LEDS.times.map do
        Drawing::Nothing.new
      end
      row << Drawing::Image.new(Gosu::Image.from_text("SET", _line_height = 12))
      row << Drawing::Image.new(Gosu::Image.from_text("RUN", _line_height = 12))
      grid << row
      row = @switch_register.map do |switch|
        Drawing::Padding.new(switch, padding: 4)
      end
      row << Drawing::Padding.new(@reset_switch, padding: 4)
      row << Drawing::Padding.new(@run_switch, padding: 4)
      grid << row
      row = NUM_LEDS.times.map { Drawing::Nothing.new }
      row << Drawing::Nothing.new
      row << Drawing::Image.new(Gosu::Image.from_text("HALT", _line_height = 12))
      grid << row
      @top_element = grid
   end

    def try_mouse_event(event)
      @top_element.try_mouse_event(mouse_x, mouse_y, event)
    end
    
  end

end
