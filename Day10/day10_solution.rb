# frozen_string_literal: true

class Day10
  def initialize
    input = File.readlines('day10_input.txt').map { |line| line.strip.split('').map(&:strip) }
    problems_solutions(input)
  end

  def problems_solutions(input)
    points_table = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
    bracket_pairs = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    illegal_chars = []
    incomplete_lines_scores = []
    input.each_with_index do |line, _index|
      illegal_closing_char = check_if_corrupted(line, bracket_pairs)
      if !illegal_closing_char.nil?
        illegal_chars.push(illegal_closing_char)
      else
        incomplete_lines_scores.push(get_incomplete_line_score(line, bracket_pairs))
      end
    end
    problem_one_answer = illegal_chars.map { |e| points_table[e] }.sum
    puts "problem 1 answer: #{problem_one_answer}" # correct answer 316851
    problem_two_answer = incomplete_lines_scores.sort[(illegal_chars.size - 1) / 2]
    puts "problem 2 answer: #{problem_two_answer}" # correct answer 2182912364
  end

  def check_if_corrupted(line, bracket_pairs)
    line_current_state = {}
    depth = 0
    line.each_with_index do |char, _index|
      if bracket_pairs.keys.include?(char)
        depth += 1
        line_current_state.store(depth, char)
      else
        closing_bracket = char
        opening_bracket_at_depth = line_current_state[depth]
        if bracket_pairs[opening_bracket_at_depth] != closing_bracket
          return closing_bracket
        else
          line_current_state[depth] = nil
          depth -= 1
        end
      end
    end
    nil
  end

  def get_incomplete_line_score(line, bracket_pairs)
    line_current_state = {}
    depth = 0
    line.each_with_index do |char, _index|
      if bracket_pairs.keys.include?(char)
        depth += 1
        line_current_state.store(depth, char)
      else
        line_current_state[depth] = nil
        depth -= 1
      end
    end
    score = 0
    scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
    line_current_state.sort.reverse.map do |_key, value|
      next if value.nil?

      bracket = bracket_pairs[value]
      score *= 5
      score += scores[bracket]
    end
    score
  end
end

Day10.new
