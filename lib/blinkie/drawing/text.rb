require "gosu"

require_relative "draws_image"

module Blinkie
  module Drawing
    
    class Text

      include DrawsImage

      def initialize(text, line_height: 12)
        @image = Gosu::Image.from_text(text, line_height)
      end

    end

  end
end
