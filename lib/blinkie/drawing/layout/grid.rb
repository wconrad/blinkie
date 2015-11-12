require_relative "../is_visual_element"

module Blinkie
  module Drawing
    module Layout

      class Grid

        extend Forwardable
        include IsVisualElement

        def initialize(rows = [])
          @rows = rows
        end

        def_delegator :@rows, :"<<"

        def update
          @rows.each do |row|
            row.each(&:update)
          end
        end

        def draw(left, top)
          widths = column_widths
          heights = row_heights
          @rows.each_with_index do |row, row_num|
            x = left
            row.each_with_index do |element, col_num|
              element.draw(x, top)
              x += widths[col_num]
            end
            top += heights[row_num]
          end
        end

        def width
          column_widths.inject(0, &:+)
        end

        def height
          row_heights.inject(0, &:+)
        end

        def mouse_event(x, y, event)
          orig_x = x
          widths = column_widths
          heights = row_heights
          @rows.each_with_index do |row, row_num|
            x = orig_x
            row.each_with_index do |element, col_num|
              return true if element.try_mouse_event(x, y, event)
              x -= widths[col_num]
            end
            y -= heights[row_num]
          end
          false
        end

        private

        def column_widths
          num_columns.times.map do |col_num|
            column_width(col_num)
          end
        end

        def num_columns
          @rows.map(&:size).max
        end

        def column_width(col_num)
          @rows.map do |row|
            (row[col_num] || Nothing.new).width
          end.max
        end

        def row_heights
          @rows.map do |row|
            row.map(&:height).max
          end
        end

      end

    end
  end
end
