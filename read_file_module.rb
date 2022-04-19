module Read_file
    class Initial_life_state
        GENERATION = 1
        ROW = 2
        COLUMN = 3
        INITIAL_BOARD_ROW = 4
        def initialize(file_name)
            @file = read_file(file_name)
            @board_array = Array.new(@file[ROW].to_i) { Array.new(@file[COLUMN].to_i) { 0 } }
            @original_board = @file[INITIAL_BOARD_ROW...]
            @integers_board = array_integers_board
            @base_board = {}
        end

        def number_of_rows
            begin  
                file_row = @file[ROW].to_i
                if file_row.nil? || file_row < 1
                    raise 'Error with ROW value !'
                end
            rescue Exception => e  
                puts e.message  
                puts e.backtrace.inspect 
            else
                return file_row
            end
        end

        def number_of_columns
            begin  
                file_column = @file[COLUMN].to_i
                if file_column.nil? || file_column < 1
                    raise 'Error with COLUMN value !'
                end
            rescue Exception => e  
                puts e.message  
                puts e.backtrace.inspect 
            else
                return file_column
            end
        end

        def generation_number
            begin  
                generation_number = @file[GENERATION].to_i
                if generation_number.nil? || generation_number < 1
                    raise 'Error with GENERATION value !'
                end
            rescue Exception => e  
                puts e.message  
                puts e.backtrace.inspect 
            else
                return generation_number
            end
        end

        def original_board
            return @original_board
        end

        def array_board
            return @board_array
        end

        def array_length
            return @file.length()
        end

        def show_file
            return @file
        end

        def integer_array
            return @integers_board
        end

        def file_input_pattern_to_board
            @base_board = {}
            for i in (0...@integers_board.size)
                for j in (0...@integers_board[i].length)
                    if @integers_board[i][j]==1
                        @base_board[[j, i]] = true
                    end
                end
            end
            return @base_board
        end

        private
        def array_integers_board
            return original_board
                .map{|n| n.tr('.', '0')}    #convert '.' to '0'
                .map{|n| n.tr('*', '1')}    #convert '*' to '1'
                .map{|n| n.chars.to_a}      #convert string to chars arrays
                .map{|n| n.map{|m| m.to_i}} #convert chars to integer
        end

        def read_file(file_name)
            begin  
                file_to_read = File.read(file_name).split
                if file_to_read.empty? || file_to_read.nil?
                    raise 'There is no file or is empty!'
                end
            rescue Exception => e  
                puts e.message  
                puts e.backtrace.inspect 
            else
                return file_to_read
            end
        end
    end
end