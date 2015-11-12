module Blinkie
  module Drawing
    module AcceptsMouseEvents

      def try_mouse_event(x, y, event)
        return false unless in_bounds?(x, y)
        mouse_event(x, y, event)
        true
      end

      def mouse_event(x, y, event)
        ql {[self.class.name, x, y, event]} #DEBUG
      end

      def in_bounds?(x, y)
        (0...width).cover?(x) &&
          (0...height).cover?(y)
      end
      
    end
  end
end
