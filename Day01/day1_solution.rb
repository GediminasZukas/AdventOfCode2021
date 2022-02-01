# frozen_string_literal: true

class Day1
  def initialize
    input = File.read('day1_input.txt').split.map(&:to_i)
    problem_1(input)
    problem_2(input)
  end

  def problem_1(input)
    answer = 0
    (1...input.size).each do |i|
      answer += 1 if input[i] > input[i - 1]
    end
    puts "problem 1 answer: #{answer}"
  end

  def problem_2(input)
    answer = 0
    previous_window_sum = -1
    (0...input.size).each do |i|
      next unless i + 2 < input.size

      current_window_sum = 0
      current_window_sum += input[i]
      current_window_sum += input[i + 1]
      current_window_sum += input[i + 2]
      if previous_window_sum != -1 && current_window_sum > previous_window_sum
        answer += 1
      end
      previous_window_sum = current_window_sum
    end
    puts "problem 2 answer: #{answer}"
  end
end

Day1.new
