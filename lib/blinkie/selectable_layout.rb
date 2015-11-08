require "forwardable"

module Blinkie

  #todo move into separate file
  
  #todo move all of the drawing machinery into a namespace/subdir
  #todo move the layouts into a namespace nested within that
  class SelectableLayout

    extend Forwardable

    def initialize(element_hash)
      @element_hash = Hash(element_hash)
    end

    def select(key)
      @key = key
    end

    def_delegators :selected_element,
                   :draw,
                   :update,
                   :width,
                   :height

    private

    def selected_element
      @element_hash.fetch(@key)
    end

  end

end
