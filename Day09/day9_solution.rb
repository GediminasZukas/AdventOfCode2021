# frozen_string_literal: true

class Day9
  def initialize
    input = File.readlines('day9_input.txt').map { |line| line.strip.split('').map(&:strip).map(&:to_i) }
    problem_one_solution(input)
  end

  def problem_one_solution(input)
    low_points = []
    input.each_with_index do |row, row_index|
      row.each_with_index do |point, column_index|
        check_for_low_point(low_points, input, point, row_index, column_index)
      end
    end
    answer = low_points.sum + low_points.size
    puts "problem 1 answer: #{answer}" # correct answer 588
  end

  def check_for_low_point(low_points, input, point, row_index, column_index)
    adjacent_locations = []
    unless column_index - 1 < 0
      adjacent_locations.push(input[row_index][column_index - 1]) # left
    end
    unless column_index + 1 >= input[row_index].size
      adjacent_locations.push(input[row_index][column_index + 1]) # right
    end
    unless row_index - 1 < 0
      adjacent_locations.push(input[row_index - 1][column_index]) # top
    end
    unless row_index + 1 >= input.size
      adjacent_locations.push(input[row_index + 1][column_index]) # down
    end
    low_points.push(point) if adjacent_locations.min > point
  end
end

Day9.new
