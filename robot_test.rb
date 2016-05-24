require 'minitest/autorun'
require 'minitest/spec'
require_relative 'robot'

describe Robot do

  before do
    @testobj = Robot.new
  end

  describe "when just created" do
    
    it "is looking at the void" do
      @testobj.facing.must_equal ""
    end

    it "should not be on the table doing nothing" do
      @testobj.xpos.must_equal -1
      @testobj.ypos.must_equal -1
      @testobj.on_the_table.must_equal false
      @testobj.report.must_equal "Robot is not on the table -- doing nothing."
    end
  end

end


