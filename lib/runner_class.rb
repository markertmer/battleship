require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BattleshipRunner

  def initialize
    @user_board = Board.new
    @comp_board = Board.new

  end

  def start
    main_menu
    comp_place
    user_place
  end

  def main_menu
    print "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n>"
    input = gets.chomp
    if input == "q"
      exit
    end
  end

  def comp_place
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)

    cells = ["A1", "B2", "C3"]
    until @comp_board.valid_placement?(@cruiser, cells)
      cells = @comp_board.cells.keys.sample(3)
    end

    @comp_board.place(@cruiser, cells)

    cells = ["A1", "B2"]
    until @comp_board.valid_placement?(@submarine, cells)
      cells = @comp_board.cells.keys.sample(2)
    end

    @comp_board.place(@submarine, cells)

  end

  def user_place
    @user_cruiser = Ship.new("cruiser", 3)
    @user_submarine = Ship.new("submarine", 2)

    puts @user_board.render
    puts "Enter the squares for the Cruiser (3 spaces):\n>"
    input = gets.chomp
    user_coords = coordinate_scrubber(input)

    until @user_board.valid_placement?(@user_cruiser, user_coords)
      puts "Those coordinates suck! Try again\n>"
      input = gets.chomp
      user_coords = coordinate_scrubber(input)
    end
    @user_board.place(@user_cruiser, user_coords)

    puts @user_board.render
    puts "Enter the squares for the Submarine (2 spaces):\n>"
    input = gets.chomp
    user_coords = coordinate_scrubber(input)

    until @user_board.valid_placement?(@user_submarine, user_coords)
      puts "Those coordinates suck! Try again\n>"
      input = gets.chomp
      user_coords = coordinate_scrubber(input)
    end
    @user_board.place(@user_submarine, user_coords)

    puts @user_board.render(true)

  end

  def coordinate_scrubber(input)
    input.delete!(",")
    input.delete!(" ")
    input.upcase!

    array = input.split("").to_a
    user_coords = []
    coord = ""
    array.each do |x|
      if coord.length < 2
        coord += x
      end
      if coord.length == 2
        user_coords << coord
        coord = ""
      end
    end
    return user_coords
  end
end
