require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/command'
require_relative '../lib/robot'
require_relative '../lib/tabletop'

describe Command do

  describe "#create" do
  
    it "can create a MOVE command" do
      command = Command.new("MOVE")
      command.operation.must_equal "MOVE"
      command.params.must_be_nil
    end

    it "can create a REPORT comand" do
      command = Command.new("REPORT")
      command.operation.must_equal "REPORT"
      command.params.must_be_nil
    end

    it "can create a LEFT comand" do
      command = Command.new("LEFT")
      command.operation.must_equal "LEFT"
      command.params.must_be_nil
    end

    it "can create a RIGHT comand" do
      command = Command.new("RIGHT")
      command.operation.must_equal "RIGHT"
      command.params.must_be_nil
    end

    it "can create a PLACE comand" do
      command = Command.new("PLACE", ["PLACE 1, 1, NORTH", "1", "1", "NORTH"])
      command.operation.must_equal "PLACE"
      command.params.must_equal ["PLACE 1, 1, NORTH", "1", "1", "NORTH"]
    end
  end

  describe "#is_valid?" do

    before do
      @robot = Robot.new
      @tabletop = TableTop.new
      @commands = []
      @valid_commands = %w[PLACE REPORT MOVE LEFT RIGHT]
    end

    after do
      @commands.clear
    end

    describe "when a valid command is received" do
      it "succeeds on MOVE command" do
        command = Command.new("MOVE")
        command.is_valid?(@robot).must_equal true
      end

      it "succeeds on LEFT command" do
        command = Command.new("LEFT")
        command.is_valid?(@robot).must_equal true
      end

      it "succeeds on RIGHT command" do
        command = Command.new("RIGHT")
        command.is_valid?(@robot).must_equal true
      end

      it "succeeds on PLACE command" do
        command = Command.new("PLACE", ["PLACE 1, 1, NORTH", "1", "1", "NORTH"])
        command.is_valid?(@robot).must_equal true
      end

      it "succeeds on REPORT command" do
        command = Command.new("REPORT")
        command.is_valid?(@robot).must_equal true
      end

    end
  end
end
