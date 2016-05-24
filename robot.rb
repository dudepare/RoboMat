class Robot

  attr_reader :xpos, :ypos, :facing
  attr_accessor :on_the_table
  def initialize()
    @xpos = -1
    @ypos = -1
    @on_the_table = false
    @facing = ""
    @directions = %w[N E S W]
  end

  # this assumes the command is already valid
  # all we need is to perform the command
  def do(command)
    puts case command.operation
    when "REPORT"
      report()
    when "MOVE"
      move()
    when "LEFT"
      left()
    when "RIGHT"
      right()
    when "PLACE"
      place(command.params)
    end
  end

  def report(args = nil)
    puts "called : report()"
    output = ""
    if @on_the_table
      output = "Robot is at (#{xpos}, #{ypos}) facing #{@facing}"
    else
      output = "Robot is not on the table -- doing nothing."
    end
  end

  def move(args = nil)
    puts "called : move()"
    if @on_the_table
      puts case @facing
      when 'e', 'E'
        @xpos += 1
      when 'n', 'N'
        @ypos += 1
      when 'w', 'W'
        @xpos -= 1
      when 's', 'S'
        @ypos -= 1
      end
    end    
  end

  def place(args = nil)
    puts "called : place()"
    @xpos = args['xpos'].to_i
    @ypos = args['ypos'].to_i
    @facing = args['direction'].upcase[0]
    @on_the_table = true
    report()
  end

  def left(args = nil)
    puts "called: left()"
    index = @directions.index(@facing)
    puts "Robot was facing #{@directions[index]}"
    if index
      index -= 1
      if index < 0
        index = @directions.length - 1
      end
      @facing = @directions[index]
      puts "Robot is now facing #{@directions[index]}"
    else
      puts "Robot is facing the ground."
    end
  end

  def right(args = nil)
    puts "called: right()"
    index = @directions.index(@facing)
    puts "Robot was facing #{@directions[index]}"
    if index
      index += 1
      if index > @directions.length - 1
        index = 0
      end
      @facing = @directions[index]
      puts "Robot is now facing #{@directions[index]}"
    else
      puts "Robot is facing the ground."
    end
  end
end



