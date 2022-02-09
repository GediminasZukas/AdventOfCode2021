# frozen_string_literal: true

class Day6
  def initialize
    input = File.read('day6_input.txt').split(',').map(&:to_i)
    problems_solution(input)
  end

  def problems_solution(initial_fishes_state)
    fishes_states = initial_fishes_state
    days = 256 # change number of days according to problem description
    growth_according_fish_state = {}

    fishes_states.each do |state|
      calculate_growth_if_needed(growth_according_fish_state, state, days)
    end

    fishes_states_at_mid = calculate(fishes_states, days / 2)

    total_fishes = 0
    fishes_states_at_mid.each do |state|
      calculate_growth_if_needed(growth_according_fish_state, state, days)
      total_fishes += growth_according_fish_state[state]
    end

    puts "problem answer: #{total_fishes}" # correct answer for problem 1: 385391, correct answer for problem 2: 1728611055389
  end

  def calculate_growth_if_needed(growth_according_fish_state, state, days)
    unless growth_according_fish_state.key?(state)
      growth_according_fish_state.store(state, calculate([state], days / 2).count)
    end
  end

  def calculate(fishes, days_until)
    fishes_states = fishes
    (1..days_until).each do |_day|
      new_fishes = []
      fishes_states.each_with_index do |state, index|
        if state == 0
          fishes_states[index] = 6
          new_fishes.push(8)
        else
          fishes_states[index] = state - 1
        end
      end
      fishes_states += new_fishes
    end
    fishes_states
  end
end

Day6.new
