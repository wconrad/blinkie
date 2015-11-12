require_relative "accepts_mouse_events"
require_relative "is_drawable"

module Blinkie
  module Drawing

    module IsVisualElement

      include AcceptsMouseEvents
      include IsDrawable

    end

  end
end
