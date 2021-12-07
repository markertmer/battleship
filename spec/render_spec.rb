require './lib/ship'
require './lib/cell'
require './lib/render'
require 'pry'

RSpec.describe "Render" do
  it "exists" do
    cell_1 = Cell.new("B4")
    expect(cell_1).to be_instance_of(Cell)
  end
end
