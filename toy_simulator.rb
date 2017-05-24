require './toy_robot'

module ToySimulator
  def self.execute_script(path)
    toy_robot = ToyRobot.new
    File.foreach(path) do |line|
      toy_robot.execute(line)
    end
    puts toy_robot.report
  end
end

ToySimulator.execute_script(ARGV.first)