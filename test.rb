require "./toy_robot"
require 'test-unit'

# Report Test
class ToyRobotTest < Test::Unit::TestCase
  test "can be placed" do
    toy_robot = ToyRobot.new
    assert toy_robot.place(0, 0, :north)
    refute toy_robot.place(4, 5, :north) # Out of bounds
  end

  test "cannot act if not placed" do
    toy_robot = ToyRobot.new
    assert_raise(ToyRobot::NoSurfaceError) { toy_robot.move }
    assert_raise(ToyRobot::NoSurfaceError) { toy_robot.left }
    assert_raise(ToyRobot::NoSurfaceError) { toy_robot.right }
    assert_raise(ToyRobot::NoSurfaceError) { toy_robot.report }
  end

  test "can ignore surface actions" do
    toy_robot = ToyRobot.new
    refute toy_robot.ignore_surface_action
    toy_robot.toggle_ignore_surface_action
    assert toy_robot.ignore_surface_action

    assert_nil toy_robot.move
  end

  test "can report" do
    toy_robot = ToyRobot.new
    toy_robot.place(0, 0, :north)
    assert toy_robot.report == '0,0,NORTH'
  end

  test "can move" do
    toy_robot = ToyRobot.new
    toy_robot.place(0, 0, :north)
    assert toy_robot.report == '0,0,NORTH' # Sanity test

    toy_robot.move
    assert toy_robot.report == '0,1,NORTH'
  end

  test "can change direction" do
    toy_robot = ToyRobot.new
    toy_robot.place(0, 0, :north)
    assert toy_robot.report == '0,0,NORTH' # Sanity test

    toy_robot.left
    assert toy_robot.report == '0,0,WEST'
  end

  test "can move and change direction" do
    toy_robot = ToyRobot.new
    toy_robot.place(1, 2, :east)
    assert toy_robot.report == '1,2,EAST' # Sanity test

    toy_robot.move
    toy_robot.move
    toy_robot.left
    toy_robot.move
    assert toy_robot.report == '3,3,NORTH'
  end

  test "movement left" do
    toy_robot = ToyRobot.new
    toy_robot.place(0, 0, :north)
    assert toy_robot.report == '0,0,NORTH' # Sanity test

    assert toy_robot.left == :west
    assert toy_robot.left == :south
    assert toy_robot.left == :east
    assert toy_robot.left == :north
  end

  test "movement right" do
    toy_robot = ToyRobot.new
    toy_robot.place(0, 0, :north)

    assert toy_robot.right == :east
    assert toy_robot.right == :south
    assert toy_robot.right == :west
    assert toy_robot.right == :north
  end

  test "should not fall" do
    toy_robot = ToyRobot.new
    toy_robot.place(4, 4, :north)
    refute toy_robot.move
    assert toy_robot.report == '4,4,NORTH'

    toy_robot = ToyRobot.new
    toy_robot.place(4, 4, :east)
    refute toy_robot.move
    assert toy_robot.report == '4,4,EAST'

    toy_robot = ToyRobot.new
    toy_robot.place(4, 0, :south)
    refute toy_robot.move
    assert toy_robot.report == '4,0,SOUTH'

    toy_robot = ToyRobot.new
    toy_robot.place(0, 4, :west)
    refute toy_robot.move
    assert toy_robot.report == '0,4,WEST'
  end
end