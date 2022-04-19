$LOAD_PATH << '.'

#Libraries needed and ruby2d must be installed 
#according this website: https://www.ruby2d.com/learn/get-started/
require 'ruby2d'
require 'read_file_module'
require 'gui_module'

#Command line and arguments
if ARGV.length != 1
  puts "\nERROR: Too few arguments"
  puts "The path and filename to the board initial state must be declared!\n\n"
  exit
elsif ARGV.nil? || ARGV.empty?
  puts "\nERROR: Empty arguments"
  puts "The path and filename to the board initial state must be declared!\n\n"
else
  puts "\n
  Press 'p' to play and pause;\n
  Press 'r' to reset the board to initial state;\n
  Press 'c' to clear the board or;\n
  Press 'x' to exit program.\n

  Also you can use the mouse to interact with the board.\n
  Let's start to have some fun! :D\n\n"
end

#Input file defined in command line to initiate board state
initial_state = Read_file::Initial_life_state
    .new(ARGV[0])

#Initializing graphical window
gui_window = GUI_module::Graphical_window
    .new(initial_state.number_of_rows,initial_state.number_of_columns)

#Set the initial generation number
count_generation_number = initial_state.generation_number
gem = Text.new("Generation: #{count_generation_number}")

#Setting graphical window parameters
set background: gui_window.window_background
set height: gui_window.window_height
set width: gui_window.window_width
count = 0
set title: "Game of life"

#Initializing board
board = GUI_module::Board.new(initial_state.file_input_pattern_to_board)

#Setting the window frame rate

update do
  clear
  board.draw_lines
  board.draw_alive_squares
  board.draw_text(count_generation_number)
  if Window.frames % 30 == 0
    board.advance_frame
  end
end

#Mouse event that make you be able to interact with the board
on :mouse_down do |event|
  board.toggle(event.x / board.cell_size, event.y / board.cell_size)
end

#Keyboard event, press 'p' to play and pause, 'r' to reset the 
#board to initial state, 'c' to clear the board and 'x' exit program.
on :key_down do |event|
  if event.key == 'p'
    board.play_pause
  end

  if event.key == 'r'
    board.reset
  end

  if event.key == 'c'
    board.clear
  end

  if event.key == 'x'
    exit
  end
end

show