require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BattleshipRunner

  def initialize
    @player_board = Board.new
    @computer_board = Board.new

  end

  def start
    main_menu
    comp_place
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
    x = cell_random(3)
    if @computer_board.valid_placement?(@cruiser, x)
      @computer_board.place(@cruiser, x)
    else
      x = cell_random(3)
      
    end

    binding.pry

    # until @computer_board.valid_placement?(@cruiser, x)
    #  x
    end
  end

    def cell_random(num)
      random_cells = @computer_board.cells.keys.sample(num)
    end



end
