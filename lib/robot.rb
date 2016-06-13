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

  def report(args = nil)
    output = ""
    if @on_the_table
      output = "Robot is at (#{xpos}, #{ypos}) facing #{@facing}"
    else
      output = "Robot is not on the table -- doing nothing."
    end
    puts output
  end

  def move(args = nil)
    if not @on_the_table
      return
    end
    case @facing
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

  def place(args = nil)
    @xpos = args[1].to_i
    @ypos = args[2].to_i
    @facing = args[3].upcase[0]
    @on_the_table = true
    report()
  end

  def left(args = nil)
    if not @on_the_table
      return
    end

    index = @directions.index(@facing)
    if index
      index -= 1
      if index < 0
        index = @directions.length - 1
      end
      @facing = @directions[index]
    else
      puts "Robot is facing the ground."
    end
  end

  def right(args = nil)
    if not @on_the_table
      return
    end

    index = @directions.index(@facing)
    if index
      index += 1
      if index > @directions.length - 1
        index = 0
      end
      @facing = @directions[index]
    else
      puts "Robot is facing the ground."
    end
  end
 
  public :report, :move, :place, :left, :right
end
