class Command
  attr_reader :operation, :params
  attr_writer :result

  # Holds the commands for the robot
  def initialize(cmd, params=nil)
    @operation = cmd
    @params = params
    @result = false
  end

  def to_s
    result = "Command #{@operation}" 
    if @params
      result += " with arguments #{@params}"
    end
    result
  end

  def place_within_table?(table)
    x = @params[1].to_i
    y = @params[2].to_i
    valid = table.is_point_inside?(x, y)
  end

  def move_within_table?(robot, table)
    x = robot.xpos
    y = robot.ypos
    f = robot.facing
    case f
    when 'E'
      x = x + 1
    when 'N'
      y = y + 1
    when 'W'
      x = x - 1
    when 'S'
      y = y - 1
    end
    valid = table.is_point_inside?(x, y)
  end

  def is_valid?(robot, tabletop)
    valid = true
    if not robot.on_the_table
      valid = @operation != "PLACE" ? false : place_within_table?(tabletop)
    else
      check_commands = %w[MOVE PLACE]
      if check_commands.include? @operation
        case @operation
        when "MOVE"
          valid = move_within_table?(robot, tabletop)
        when "PLACE"   
          valid = place_within_table?(tabletop)
        end
      end
    end
    valid    
  end

  private :move_within_table?, :place_within_table?
  public :is_valid?

end

class CommandParser

  attr_reader :commands
  PLACE_REGX = /PLACE\s+(?<xpos>\d)\s*,\s*(?<ypos>\d)\s*,\s*(?<direction>EAST|WEST|NORTH|SOUTH)/

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
