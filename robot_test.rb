require 'minitest/autorun'
require 'minitest/spec'
require_relative 'robot'

describe Robot, "Test suite for the robot class" do

  before do
    @robot = Robot.new
  end

  after do 
    @robot.destroy!
  end

  describe "#create" do
    
    it "is looking at the void" do
      @robot.facing.must_equal ""
    end

    it "should not be on the table doing nothing" do
      @robot.xpos.must_equal -1
      @robot.ypos.must_equal -1
      @robot.on_the_table.must_equal false
    end
  end

end


