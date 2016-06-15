require_relative "compass"

class Robot

  def initialize()
    @xpos = -1
    @ypos = -1
    @facing = ""
    @compass = Compass.new
  end

  def is_valid?(xpos, ypos, table)
    table.is_point_inside?(xpos, ypos)
  end

  def on_the_table
    (@xpos != -1) and (@ypos != -1) and !@facing.empty?
  end

  def report(args)
    return false if !on_the_table

    output = "Robot is at (#{@xpos}, #{@ypos}) facing #{@facing}"
    puts output

    true
  end

  def move(args)
    return false if !on_the_table
    
    xpos = @xpos
    ypos = @ypos

    offset = @compass.coordinates
    
    xpos += offset[0]
    ypos += offset[1]

    if result = is_valid?(xpos, ypos, args.last)
      @xpos = xpos
      @ypos = ypos
    end
    result
  end

  def place(args)
    xpos = args[1].to_i
    ypos = args[2].to_i
    table = args.last
    
    if result = is_valid?(xpos, ypos, table)
      @xpos = xpos
      @ypos = ypos
      @facing = args[3].upcase[0]
      @compass.set_direction(@facing)
      report(args)
    end
    result
  end

  def left(args)
    return false if !on_the_table

    @compass.rotate_left
    @facing = @compass.where

    true
  end

  def right(args)
    return false if !on_the_table
  
    @compass.rotate_right
    @facing = @compass.where

    true
  end
 
  public :report, :move, :place, :left, :right, :on_the_table
end
