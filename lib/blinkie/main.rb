require_relative "debug"
require_relative "main_window"

module Blinkie

  class Main

    def call
      window = MainWindow.new
      window.show
    end
    
  end

end
