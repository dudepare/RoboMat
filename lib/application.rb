require_relative "command"
require_relative "robot"
require_relative "tabletop"

class Application

  def self.run(instream)
    @table = TableTop.new
    @robot = Robot.new
    
    @cmd_parser = CommandParser.new(instream)

    if instream.nil?
      self.interactive_mode
    else
      self.commandline_mode
    end
  end

  def self.execute(cmd)
    if cmd.is_valid?(@robot, @table)

      operation = cmd.operation.downcase
      if @robot.respond_to?(operation)
        @robot.send(operation, cmd.params)
      else
        puts "#{cmd} not available"
        return
      end

      @table.set_position(@robot.xpos, @robot.ypos)
    else
      puts "#{cmd} not valid"
    end
  end

  def self.commandline_mode
    @cmd_parser.load_commands
    commands = @cmd_parser.commands   
    commands.each do | cmd | 
      self.execute(cmd)
    end
  end

  def self.interactive_mode
    loop do
      line = @cmd_parser.get_command
      break if line.chomp.empty?
      command = @cmd_parser.parse_command(line)
      self.execute(command)
    end
  end

end
