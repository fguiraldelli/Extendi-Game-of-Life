module GUI_module
    class Graphical_window
      def initialize(number_of_rows, 
        number_of_columns, cell_size = 40, background_color = 'black')
        @cell_size = cell_size
        @number_of_rows = number_of_rows
        @number_of_columns = number_of_columns
        @height = cell_size * number_of_rows
        @width = cell_size * number_of_columns
        @background_color = background_color
      end

      def window_background
        return @background
      end

      def window_height
        return @height
      end

      def window_width
        return @width
      end

      def window_cell_size
        return @cell_size
      end

    end

    class Board
      def initialize(board, cell_size = 40, 
        line_color = Color.new('lime'), 
        square_color = Color.new('green') )
        @initial_board = @board = board
        @line_color = line_color
        @square_color = square_color
        @playing = false
        @cell_size = cell_size
        @count = -1
      end

      def clear
        @board = {}
      end

      def cell_size
        return @cell_size
      end

      def reset
        @board = @initial_board
        @count = -1
      end

      def set_board(board)
        @board = board
      end

      def play_pause
        @playing = !@playing
      end

      def draw_text(count)
        if @count < 0
          @count = count
        end
        Text.new(
          "Generation #{@count}",
          x: 0, y: 0,
          style: 'bold',
          size: 20,
          color: 'white',
          rotate: 0,
          z: 0
        )
      end


      def draw_lines
        (Window.width / @cell_size).times do |x|
          Line.new(
            width: 1,
            color: @line_color,
            y1: 0,
            y2: Window.height,
            x1: x * @cell_size,
            x2: x * @cell_size,
          )

          (Window.height / @cell_size).times do |y|
            Line.new(
              width: 1,
              color: @line_color,
              x1: 0,
              x2: Window.width,
              y1: y * @cell_size,
              y2: y * @cell_size,
            )
          end
        end

        def toggle(x, y)
          if @board.has_key?([x, y])
            @board.delete([x, y])
          else
            @board[[x, y]] = true
          end
        end

        def draw_alive_squares
          @board.keys.each do |x, y|
            Square.new(
              color: @square_color,
              x: x * @cell_size,
              y: y * @cell_size,
              size: @cell_size
            )
          end
        end

        def advance_frame
          if @playing
            new_board = {}

            (Window.width / @cell_size).times do |x|
              (Window.height / @cell_size).times do |y|
                alive = @board.has_key?([x, y])

                alive_neighbours = [
                  @board.has_key?([x-1, y-1]), # Top Left
                  @board.has_key?([x  , y-1]), # Top
                  @board.has_key?([x+1, y-1]), # Top Right
                  @board.has_key?([x+1, y  ]), # Right
                  @board.has_key?([x+1, y+1]), # Bottom Right
                  @board.has_key?([x  , y+1]), # Bottom
                  @board.has_key?([x-1, y+1]), # Bottom left
                  @board.has_key?([x-1, y  ]), # left
                ].count(true)

                if((alive && alive_neighbours.between?(2,3)) || (!alive && alive_neighbours == 3))
                  new_board[[x, y]] = true
                end
              end
            end
            @board = new_board
            @count += 1
          end
        end
      end
    end
end