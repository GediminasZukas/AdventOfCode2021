# frozen_string_literal: true

class Day9
  $VERBOSE = nil
  @@basin_size = 0
  @@visited_coords = []

  def initialize
    input = File.readlines('day9_input.txt').map { |line| line.strip.split('').map(&:strip).map(&:to_i) }
    low_points_data = problem_one_solution(input)
    problem_two_solution(input, low_points_data)
  end

  def problem_one_solution(input)
    low_points = []
    input.each_with_index do |row, row_index|
      row.each_with_index do |point, column_index|
        check_for_low_point(low_points, input, point, row_index, column_index)
      end
    end
    answer = low_points.map { |point_data| point_data.keys.first }.sum + low_points.size
    puts "problem 1 answer: #{answer}" # correct answer 588
    low_points
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
    low_points.push(point => [row_index, column_index]) if adjacent_locations.min > point
  end
end

def problem_two_solution(input, low_points_data)
  basins = []
  low_points_data.each do |point|
    @@visited_coords = []
    @@basin_size = 1
    start_coordinates = point.values.first
    traverse_basin(input, start_coordinates)
    basins.push(@@basin_size)
  end
  answer = basins.sort.last(3).inject(:*)
  puts "problem 2 answer: #{answer}" # correct answer 964712
end

def traverse_basin(input, coordinates)
  row = coordinates[0]
  column = coordinates[1]
  value = input[row][column]

  if row - 1 >= 0 && input[row - 1][column] < 9 && input[row - 1][column] > value && !@@visited_coords.include?([row - 1, column])
    @@visited_coords.push([row - 1, column])
    @@basin_size += 1
    traverse_basin(input, [row - 1, column]) # go up
  end
  if column + 1 < input[row].size && input[row][column + 1] < 9 && input[row][column + 1] > value && !@@visited_coords.include?([row, column + 1])
    @@visited_coords.push([row, column + 1])
    @@basin_size += 1
    traverse_basin(input, [row, column + 1]) # go right
  end
  if row + 1 < input.size && input[row + 1][column] < 9 && input[row + 1][column] > value && !@@visited_coords.include?([row + 1, column])
    @@visited_coords.push([row + 1, column])
    @@basin_size += 1
    traverse_basin(input, [row + 1, column]) # go down
  end
  if column - 1 >= 0 && input[row][column - 1] < 9 && input[row][column - 1] > value && !@@visited_coords.include?([row, column - 1])
    @@visited_coords.push([row, column - 1])
    @@basin_size += 1
    traverse_basin(input, [row, column - 1]) # go left
  end
end

Day9.new
