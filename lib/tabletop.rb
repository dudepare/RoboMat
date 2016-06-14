class TableTop

  def initialize(rows=5, cols=5)
    @rows = rows > 0 ? rows : 5
    @cols = cols > 0 ? cols : 5
  end

  def max_row
    @rows - 1
  end

  def max_col
    @cols - 1
  end

  def convert_x(xpos)
    @cols - (xpos + 1)
  end

  def convert_y(ypos)
    ypos
  end

  def is_point_inside?(xpos, ypos)
    xpos = convert_x(xpos)
    ypos = convert_y(ypos)
    xpos >= 0 && xpos <= max_row && ypos >= 0 && ypos <= max_col
  end

  public :is_point_inside?
  private :convert_x, :convert_y, :max_row, :max_col
end
