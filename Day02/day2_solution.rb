# frozen_string_literal: true

class Day2
  def initialize
    input = File.readlines('day2_input.txt')
    problem_1(input)
    problem_2(input)
  end

  def problem_1(input)
    horizontal_position = 0
    vertical_position = 0
    input.each do |move|
      direction, number = move.split
      horizontal_position += number.to_i if direction.start_with?('forward')
      vertical_position += number.to_i if direction.start_with?('down')
      vertical_position -= number.to_i if direction.start_with?('up')
    end
    puts "problem 1 answer: #{horizontal_position * vertical_position}"
  end

  def problem_2(input)
    aim = 0
    horizontal_position = 0
    vertical_position = 0
    input.each do |move|
      direction, number = move.split
      aim += number.to_i if direction.start_with?('down')
      aim -= number.to_i if direction.start_with?('up')
      horizontal_position += number.to_i if direction.start_with?('forward')
      vertical_position += aim * number.to_i if direction.start_with?('forward')
    end
    puts "problem 2 answer: #{horizontal_position * vertical_position}"
  end
end

Day2.new
