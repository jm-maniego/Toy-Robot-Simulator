require './surface'
require './facing'

class ToyRobot
  ACCESSIBLE_ACTIONS = %w{ place move right left report }

  def initialize(x = 0, y = 0, f = :north)
    @x, @y, @f = x, y, Facing.new(f)
    @ignore_surface_action = false
  end

  def place(x, y, f)
    @x, @y, @f = x.to_i, y.to_i, Facing.new(f)
    @place = Surface.new(5)
    valid?
  end

  def toggle_ignore_surface_action
    @ignore_surface_action = !@ignore_surface_action
  end

  def ignore_surface_action
    @ignore_surface_action
  end

  def coordinates
    [@x, @y]
  end

  def left
    act { @f.left }
  end

  def right
    act { @f.right }
  end

  def move
    act do
      @can_move = can_move?
      if @can_move
        @x, @y = @f + [@x, @y]
      end
      @can_move
    end
  end

  def report
    act do
      "#{@x},#{@y},#{@f}"
    end
  end

  def can_move?
    !@place.will_fall?(self, @f.movement)
  end

  def valid?
    !@place.will_fall?(self, [0, 0])
  end

  def execute(command)
    command = command.strip.downcase
    action, args = command.split(/\s+/, 2)
    args = args.split(/,/) if args

    raise InvalidAction, "#{action}" unless ACCESSIBLE_ACTIONS.include?(action)
    send(action, *args)
  end

  private
    def act
      raise NoSurfaceError unless @place
      return yield if valid?

    rescue NoSurfaceError => e
      raise e unless ignore_surface_action
    end

  class NoSurfaceError < Exception; end
  class InvalidAction < Exception; end
end