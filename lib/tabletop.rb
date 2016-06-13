class TableTop

  attr_reader :grid, :rows, :cols

  def initialize(rows=5, cols=5)
    @rows = rows > 0 ? rows : 5
    @cols = cols > 0 ? cols : 5
    @grid = []

    @rows.times do
      row = Array.new(@cols, 0)
      @grid << row
    end
  end

  def max_row()
    @rows - 1
  end

  def max_col()
    @cols - 1
  end

  def show()
    @rows.times do | row | 
        puts "#{@grid[row]}"
    end
  end

  def is_point_inside?(xpos, ypos)
    xpos = convert_x(xpos)
    ypos = convert_y(ypos)
    xpos >= 0 && xpos <= max_row() && ypos >= 0 && ypos <= max_col()
  end

  def set_position(xpos, ypos)
    xval = convert_x(xpos)
    yval = convert_y(ypos)
    @rows.times do | row | 
      @cols.times do | col |
        if row == xval && col == yval
          @grid[row][col] = 1
        end
      end
    end
  end

  # zeroes out our grid
  def reset()
    @rows.times do | row | 
      @cols.times do | col |
        @grid[row][col] = 0
      end
    end
  end

  def convert_x(xpos)
    @cols - (xpos + 1)
  end

  def convert_y(ypos)
    ypos
  end
end
