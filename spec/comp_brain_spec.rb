require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/comp_brain'
require 'pry'

RSpec.describe CompBrain do
  it 'exists' do
  brain = CompBrain.new
  expect(brain).to be_instance_of CompBrain
  end

  it 'collects adjacent coordinates from a hit' do
    brain = CompBrain.new
    user_board = Board.new(6)
    ship_1 = Ship.new("cruiser", 3)
    ship_2 = Ship.new("frigate", 4)
    user_board.place(ship_1, ["B2", "B3", "B4"])
    #user_board.place(ship_2, ["C6", "D6", "E6", "F6"])
    user_board.cells["B3"].fire_upon
    expect(brain.adj_coords(user_board)).to eq ["A3", "C3", "B2", "B4"]
  end


end
