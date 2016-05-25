require 'minitest/autorun'
require 'minitest/spec'
require_relative '../command'
require_relative '../robot'
require_relative '../tabletop'

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

  describe "#is_valid" do

    before do
      @robot = Robot.new
      @tabletop = TableTop.new
      @commands = []
    end

    after do
      @commands.clear
    end

    describe "when first command is not a valid PLACE command" do
      it "fails on MOVE command" do
        command = Command.new("MOVE")
        command.is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails on REPORT command" do
        command = Command.new("REPORT")
        command.is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails on LEFT command" do
        command = Command.new("LEFT")
        command.is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails on RIGHT command" do
        command = Command.new("RIGHT")
        command.is_valid?(@robot, @tabletop).must_equal false
      end
    end

    describe "when first command is a PLACE command" do
      it "fails when initial position is outside the table" do
        command = Command.new("PLACE", ["PLACE 1, -1, NORTH", "1", "-1", "NORTH"])
        command.is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails when initial position is outside the table" do
        command = Command.new("PLACE", ["PLACE 5, 5, WEST", "5", "5", "WEST"])
        command.is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails when initial position is outside the table" do
        command = Command.new("PLACE", ["PLACE 300, 0, EAST", "300", "0", "EAST"])
        command.is_valid?(@robot, @tabletop).must_equal false
      end

      it "succeeds when initial position is inside the table" do
        command = Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        command.is_valid?(@robot, @tabletop).must_equal true
      end

      it "succeeds when initial position is inside the table" do
        command = Command.new("PLACE", ["PLACE 1, 4, WEST", "1", "4", "WEST"])
        command.is_valid?(@robot, @tabletop).must_equal true
      end

      it "succeeds when initial position is inside the table" do
        command = Command.new("PLACE", ["PLACE 4, 4, NORTH", "4", "4", "NORTH"])
        command.is_valid?(@robot, @tabletop).must_equal true
      end
    end

    describe "when first command is a valid PLACE commmand" do
      it "succeeds on REPORT command" do
        @commands << Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        @commands << Command.new("REPORT")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)

        @commands[1].is_valid?(@robot, @tabletop).must_equal true
      end

      it "succeeds on LEFT command" do
        @commands << Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        @commands << Command.new("LEFT")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal true
      end

      it "succeeds on RIGHT command" do
        @commands << Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        @commands << Command.new("RIGHT")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal true
      end

      it "succeeds on MOVE command, when not facing the edge of table" do
        @commands << Command.new("PLACE", ["PLACE 0, 0, EAST", "0", "0", "EAST"])
        @commands << Command.new("MOVE")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal true
      end

      it "fails on MOVE command, when facing the edge of table" do
        @commands << Command.new("PLACE", ["PLACE 0, 0, SOUTH", "0", "0", "SOUTH"])
        @commands << Command.new("MOVE")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails on MOVE command, when facing the edge of table" do
        @commands << Command.new("PLACE", ["PLACE 0, 0, WEST", "0", "0", "WEST"])
        @commands << Command.new("MOVE")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails on MOVE command, when facing the edge of table" do
        @commands << Command.new("PLACE", ["PLACE 4, 4, EAST", "4", "4", "EAST"])
        @commands << Command.new("MOVE")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal false
      end

      it "fails on MOVE command, when facing the edge of table" do
        @commands << Command.new("PLACE", ["PLACE 4, 4, NORTH", "4", "4", "NORTH"])
        @commands << Command.new("MOVE")
        @commands[0].is_valid?(@robot, @tabletop).must_equal true
        
        @robot.do(@commands[0])
        @tabletop.set_position(@robot.xpos, @robot.ypos)
        
        @commands[1].is_valid?(@robot, @tabletop).must_equal false
      end
    end
  end
end
