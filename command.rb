class Command
  attr_reader :operation, :params
  attr_writer :result

  # Holds the commands for the robot
  def initialize(cmd, params=[])
    @operation = cmd
    @params = params
    @result = false
  end

  def to_s
    result = "Command #{@operation}" 
    if @params.length > 0
      result += " with arguments #{@params}"
    end
    result
  end

  def place_within_table?
    yes = true
    # this is the place command
    x = @params['xpos'].to_i
    y = @params['ypos'].to_i
    if not tabletop.within_table(x, y)
      yes = false
    end
    yes
  end

  def is_valid?(robot, tabletop)
    valid = true
    if not robot.on_the_table
      # all other operations are not valid
      # when robot is not on the table
      if @operation != "PLACE"
        valid = false
      else
        valid = place_within_table?
      end
    else
      check_commands = %w[MOVE PLACE]
      if check_commands.include? @operation
        puts case @operation
        when "MOVE"
          
        when "PLACE"
          valid = place_within_table?
        end
      end
    end    
  end
end

class CommandParser

  attr_reader :commands
  PLACE_REGX = /PLACE\s+(?<xpos>\d)\s*,\s*(?<ypos>\d)\s*,\s*(?<direction>EAST|WEST|NORTH|SOUTH)/

  def initialize(command_file)
    @file = command_file
    @valid_commands = %w[PLACE MOVE LEFT RIGHT REPORT]
    @commands = []
    load_commands()
  end

  def load_commands()
    IO.foreach(@file) do | line |
      line = line.chomp.upcase
      place_command = CommandParser::PLACE_REGX.match(line)
      if place_command
        @commands << Command.new("PLACE", place_command)
      elsif @valid_commands.include? line
          @commands << Command.new(line)
      end
    end
  end
end
