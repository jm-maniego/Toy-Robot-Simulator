class Facing
  N_MOVEMENT = 1

  MAPPING = {
    :north => [ 0, N_MOVEMENT],
    :east  => [ N_MOVEMENT, 0],
    :west  => [-N_MOVEMENT, 0],
    :south => [ 0,-N_MOVEMENT]
  }

  DIRECTIONS = [:north, :east, :south, :west] # Order is important for [#left, #right] methods

  def initialize(f)
    @f = f.to_sym
    @direction_index = DIRECTIONS.index(@f)
  end

  def to_s # For reporting
    @f.upcase.to_s
  end

  def left
    @direction_index -= 1
    face
  end

  def right
    @direction_index += 1
    face
  end

  def movement
    MAPPING[@f]
  end

  def +(coordinates)
    coordinates.map.with_index {|c, i| c + movement[i] }
  end

  private

    def face
      @f = DIRECTIONS[@direction_index % DIRECTIONS.length]
    end
end