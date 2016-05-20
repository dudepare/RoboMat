class Command
  # Holds the commands for the robot
  def initialize(cmd, params=[])
    @operation = cmd
    @params = params
    @result = false
  end

  def show
    puts @operation
    if @params
      puts @params
    end
  end
end


class Robot

  def initialize()
    @xpos = -1
    @ypos = -1
    @on_the_table = false
  end

  def do(command)
    
  end
end

class Surface
  # empty class for now
end

class TableTop < Surface
  def initialize(length=5, width=5)
    @length = length
    @width = width
    @area = [length * width]
    print @area
  end
end



if __FILE__ == $PROGRAM_NAME
  valid_commands = %w(PLACE MOVE LEFT RIGHT REPORT)

  robot = Robot.new
  table = TableTop.new

  commands = []

  PLACE_REGX = /PLACE\s+(?<xpos>\d)\s*,\s*(?<ypos>\d),\s*(?<direction>EAST|WEST|NORTH|SOUTH|east|west|north|south)/

  # read commands from a file
  IO.foreach("input.dat") do |line|
    place_command = PLACE_REGX.match(line)
    if valid_commands.include? line.chomp
      commands << Command.new(line)
    elsif place_command
      commands << Command.new("PLACE", place_command)
    end
  end

  commands.each do |command|
    command.show
    #robot.do(command)
  end
end
