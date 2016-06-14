class Command

  attr_reader :operation, :params
  def initialize(cmd, params=nil)
    @operation = cmd
    @params = params
  end

  def to_s
    result = "Command #{@operation}" 
    if @params
      result += " with arguments #{@params}"
    end
    result
  end

  def is_valid?(robot)
    valid = robot.respond_to?(@operation.downcase)
  end

end

class CommandParser

  attr_reader :commands
  PLACE_REGX = /PLACE\s+(?<xpos>[-]?\d)\s*,\s*(?<ypos>[-]?\d)\s*,\s*(?<direction>EAST|WEST|NORTH|SOUTH)/

  def initialize(command_file)
    @file = command_file
    @valid_commands = %w[PLACE MOVE LEFT RIGHT REPORT]
    @commands = []
  end

  def parse_command(line)
    line = line.chomp.upcase
    place_command = CommandParser::PLACE_REGX.match(line)
    if place_command
      command = Command.new("PLACE", place_command.to_a)
    elsif @valid_commands.include? line
      command = Command.new(line)
    end
    command
  end

  def load_commands
    IO.foreach(@file) do | line |
      @commands << parse_command(line)
    end
  end

  def get_command
    gets
  end
  
end
