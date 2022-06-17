# frozen_string_literal: true

require 'set'

class Day11
  def initialize
    input = File.readlines('day11_input.txt').map { |line| line.strip.split('').map(&:strip).map(&:to_i) }
    problems_solutions(input)
  end

  def problems_solutions(input)
    amount_of_flashes = 0
    step = 1
    loop do
      flashes_in_step = calculate_flashes_in_step(input).size
      amount_of_flashes += flashes_in_step unless step > 100
      if flashes_in_step == 100
        puts "problem 2 answer: #{step}" # correct answer is 276
        break
      end
      step += 1
    end
    puts "problem 1 answer: #{amount_of_flashes}" # correct answer is 1681
  end

  def calculate_flashes_in_step(input)
    flashed_number_coordinates = Set[]
    input.each_with_index do |row, row_index|
      row.each_with_index do |_, column_index|
        number = input[row_index][column_index]
        if number == 9
          flashed_number_coordinates.add([row_index, column_index])
          input[row_index][column_index] = 0
        else
          input[row_index][column_index] = number + 1
        end
      end
    end

    if flashed_number_coordinates.empty?
      flashed_number_coordinates
    else
      flashed_number_coordinates = flashed_number_coordinates.merge(calculate_rippling_flashes(input, flashed_number_coordinates))
      flashed_number_coordinates
    end
  end

  def calculate_rippling_flashes(input, flashed_number_coordinates)
    new_flashes_coordinates = Set[]
    flashed_number_coordinates.each do |coordinates|
      row = coordinates[0]
      column = coordinates[1]
      adjacents = []
      left = adjacents.push([row, column - 1]) if column - 1 >= 0
      top = adjacents.push([row - 1, column]) if row - 1 >= 0
      right = adjacents.push([row, column + 1]) if column + 1 < input[row].size
      bottom = adjacents.push([row + 1, column]) if row + 1 < input.size
      # diagonal adjacents
      adjacents.push([row - 1, column - 1]) if !left.nil? && !top.nil?
      adjacents.push([row - 1, column + 1]) if !right.nil? && !top.nil?
      adjacents.push([row + 1, column - 1]) if !left.nil? && !bottom.nil?
      adjacents.push([row + 1, column + 1]) if !right.nil? && !bottom.nil?
      adjacents.each do |adjacent|
        update_adjacent(input, adjacent, new_flashes_coordinates)
      end
    end

    total_flashes_coordinates = flashed_number_coordinates.merge(new_flashes_coordinates)
    unless new_flashes_coordinates.empty?
      total_flashes_coordinates = total_flashes_coordinates.merge(calculate_rippling_flashes(input, new_flashes_coordinates))
    end
    total_flashes_coordinates
  end

  def update_adjacent(input, coordinates, new_flashes_coordinates)
    row = coordinates[0]
    column = coordinates[1]
    value = input[row][column]
    if value == 9
      new_flashes_coordinates.add([row, column])
      input[row][column] = 0
    else
      input[row][column] = value + 1 unless value == 0
    end
    new_flashes_coordinates
  end
end

Day11.new
