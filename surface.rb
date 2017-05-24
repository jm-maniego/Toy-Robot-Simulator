class Surface
  def initialize(dimension_n=5)
    @dimension_n = dimension_n
  end

  def will_fall?(object, movement)
    object.coordinates.map.with_index.any? do |c, i|
      c += movement[i]
      c >= @dimension_n || c < 0
    end
  end
end