# frozen_string_literal: true

class Day3
  def initialize
    input = File.readlines('day3_input.txt').map(&:strip)
    problem_1(input)
    problem_2(input)
  end

  def problem_1(input)
    half_elements = input.size / 2
    sums_of_ones = calculate_sum_of_ones_in_each_idx(input)
    gamma = sums_of_ones.map { |count| count > half_elements ? 1 : 0 }
    epsilon = gamma.map { |e| e == 1 ? 0 : 1 }
    puts "problem 1 answer: #{gamma.join.to_i(2) * epsilon.join.to_i(2)}"
  end

  def problem_2(input)
    oxygen_rating = get_rating(input, '1', '0')
    scrubber_rating = get_rating(input, '0', '1')
    puts "problem 2 answer: #{oxygen_rating.join.to_i(2) * scrubber_rating.join.to_i(2)}"
  end

  def get_rating(input, p2, p3)
    current_input = input
    input.first.split('').each_index do |index|
      break if current_input.size == 1

      sums_of_ones = calculate_sum_of_ones_in_each_idx(current_input)
      number = sums_of_ones[index]
      half_elements = (current_input.size.to_f / 2.to_f).round.to_i
      target = number >= half_elements ? p2 : p3
      current_input = current_input.select { |filterable| filterable.split('')[index] == target }
    end
    current_input
  end

  def calculate_sum_of_ones_in_each_idx(input)
    array = Array.new(input.first.split('').size, 0)
    input.each do |number_char|
      number_char.split('').each_with_index do |char, index|
        array[index] += 1 if char == '1'
      end
    end
    array
  end
end

Day3.new
