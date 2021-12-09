require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BattleshipRunner

  def initialize
    @board = Board.new
  end

  def start
    main_menu
  end

  def main_menu
    print "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n>"
    input = gets.chomp
    if input == "q"
      exit
    end
    #binding.pry
  end

end
