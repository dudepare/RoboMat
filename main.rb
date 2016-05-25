require_relative "command"
require_relative "robot"
require_relative "tabletop"

def main
  table = TableTop.new
  robot = Robot.new

  cmd_parser = CommandParser.new("input.dat")
  commands = cmd_parser.commands
  commands.each do | cmd | 
    # check if the command is valid
    if cmd.is_valid?(robot, table)

      # let our robot execute the command
      robot.do(cmd)

      # update the robot's position in the table
      table.set_position(robot.xpos, robot.ypos)
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  main()
end

