require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

RSpec.describe "Cell" do
  it "exists" do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end
end
