# frozen_string_literal: true

class Day7
  def initialize
    input = File.read('day7_input.txt').split(',').map(&:to_i)
    problems_solution(input)
  end

  def problems_solution(input)
    fuel_costs = []
    positions = input.tally
    (0..input.max).each do |position|
      position_fuel_cost = positions.map { |position_group| (position_group[0] - position).abs * position_group[1] }.sum
      fuel_costs.push(position_fuel_cost)
    end

    puts "problem 1 answer: #{fuel_costs.min}" # correct answer for problem 1: 356179

    fuel_costs = []
    (0..input.max).each do |position|
      position_fuel_cost = positions.map do |position_group|
        steps_count = (position_group[0] - position).abs
        steps_cost = 0
        steps_count.times { |time| steps_cost += time + 1 }
        steps_cost * position_group[1]
      end.sum
      fuel_costs.push(position_fuel_cost)
    end

    puts "problem 2 answer: #{fuel_costs.min}" # correct answer for problem 2: 99788435
  end
end

Day7.new
