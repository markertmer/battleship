require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BattleshipRunner

  def initialize
    @player_board = Board.new
    @comp_board = Board.new

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

    cells = ["A1", "B2", "C3"]
    until @comp_board.valid_placement?(@cruiser, cells)
      cells = @comp_board.cells.keys.sample(3)
    end

    @comp_board.place(@cruiser, cells)
    binding.pry
    # @cruiser = Ship.new("cruiser", 3)
    # @submarine = Ship.new("submarine", 2)
    # x = cell_random(3)
    # if @comp_board.valid_placement?(@cruiser, x)
    #   @comp_board.place(@cruiser, x)
    # else
    #   x = cell_random(3)
    #



    # until @comp_board.valid_placement?(@cruiser, x)
    #  x

  end

    def cell_random(num)
      random_cells = @comp_board.cells.keys.sample(num)
    end



end
