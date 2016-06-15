class Compass

  attr_reader :current

  def initialize
  	@directions = %w[N E S W]
  	@offset = {
  		'N' => [0, 1],
  		'E' => [1, 0],
  		'S' => [0, -1],
  		'W' => [-1, 0]
  	}
  	@current = 0
  	@last_index = @directions.length - 1
  end

  def set_direction(facing)
  	direction = facing.upcase
  	if @directions.include?(direction)
  		@current = @directions.index(direction)
  	end
  end

  def where
  	@directions[@current]
  end

  def coordinates
  	direction = @directions[@current]
  	@offset[direction]
  end

  def rotate_left
  	@current = (@current == 0) ?  @last_index : @current - 1 
  end

  def rotate_right
  	@current = (@current == @last_index) ? 0 : @current + 1
  end

  public :set_direction, :where, :coordinates, :rotate_right, :rotate_left
end