require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/robot'
require_relative '../lib/command'
require_relative '../lib/tabletop'

describe Robot, "Test suite for the robot class" do

  before do
    @robot = Robot.new
    @commands = []
  end

  after do
    @commands.clear
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

  describe "#[command]" do
    
    describe "when first command is not a valid PLACE command" do
      it "MOVE command is ignored" do
        cmd = Command.new("MOVE")
        @robot.send(cmd.operation.downcase, cmd.params)
        @robot.on_the_table.must_equal false
        @robot.xpos.must_equal -1
        @robot.ypos.must_equal -1
        @robot.facing.must_be_empty
      end

      it "REPORT command is ignored" do
        cmd = Command.new("REPORT")
        @robot.send(cmd.operation.downcase, cmd.params)
        @robot.on_the_table.must_equal false
        @robot.xpos.must_equal -1
        @robot.ypos.must_equal -1
        @robot.facing.must_be_empty
      end

      it "LEFT command is ignored" do
        cmd = Command.new("LEFT")
        @robot.send(cmd.operation.downcase, cmd.params)
        @robot.on_the_table.must_equal false
        @robot.xpos.must_equal -1
        @robot.ypos.must_equal -1
        @robot.facing.must_be_empty
      end

      it "RIGHT command is ignored" do
        cmd = Command.new("RIGHT")
        @robot.send(cmd.operation.downcase, cmd.params)
        @robot.on_the_table.must_equal false
        @robot.xpos.must_equal -1
        @robot.ypos.must_equal -1
        @robot.facing.must_be_empty
      end
    end

    describe "when first command is a valid PLACE command" do
      it "robot is placed on the table" do
        cmd = Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        table = TableTop.new
        args = cmd.params.nil? ? [] : cmd.params
        args << table
        @robot.send(cmd.operation.downcase, args)
        @robot.on_the_table.must_equal true
        @robot.xpos.must_equal 0
        @robot.ypos.must_equal 0
        @robot.facing.must_equal "E"
      end
    end

    describe "when robot is on the table" do
      it "succeeding LEFT command gets done" do
        cmd1 = Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        table = TableTop.new
        args = cmd1.params.nil? ? [] : cmd1.params
        args << table
        @robot.send(cmd1.operation.downcase, args)
        cmd2 = Command.new("LEFT")
        @robot.send(cmd2.operation.downcase, args)
        @robot.on_the_table.must_equal true
        @robot.xpos.must_equal 0
        @robot.ypos.must_equal 0
        @robot.facing.must_equal "N"
      end

      it "succeeding RIGHT command gets done" do
        cmd1 = Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        table = TableTop.new
        args = cmd1.params.nil? ? [] : cmd1.params
        args << table
        @robot.send(cmd1.operation.downcase, args)
        cmd2 = Command.new("RIGHT")
        @robot.send(cmd2.operation.downcase, args)
        @robot.on_the_table.must_equal true
        @robot.xpos.must_equal 0
        @robot.ypos.must_equal 0
        @robot.facing.must_equal "S"
      end

      it "succeeding REPORT command gets done" do
        cmd1 = Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        table = TableTop.new
        args = cmd1.params.nil? ? [] : cmd1.params
        args << table
        @robot.send(cmd1.operation.downcase, args)
        cmd2 = Command.new("REPORT")
        @robot.send(cmd2.operation.downcase, args)
        @robot.on_the_table.must_equal true
        @robot.xpos.must_equal 0
        @robot.ypos.must_equal 0
        @robot.facing.must_equal "E"
      end
      
      it "succeeding MOVE command gets done" do
        cmd1 = Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        table = TableTop.new
        args = cmd1.params.nil? ? [] : cmd1.params
        args << table
        @robot.send(cmd1.operation.downcase, args)
        cmd2 = Command.new("MOVE")
        @robot.send(cmd2.operation.downcase, args)
        @robot.on_the_table.must_equal true
        @robot.xpos.must_equal 1
        @robot.ypos.must_equal 0
        @robot.facing.must_equal "E"
      end
    end
  end
end


