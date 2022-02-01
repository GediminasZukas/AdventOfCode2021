# frozen_string_literal: true

class Day4
  def initialize
    input = File.readlines('day4_input.txt').reject { |line| line.strip.empty? }.map(&:strip)
    problems_solution(input)
  end

  def problems_solution(input)
    winning_numbers = input.first.split(',').map(&:to_i)
    boards = input
             .reject { |line| line == input.first }
             .map { |line| line.split(' ').map(&:to_i) }
             .each_slice(5).to_a

    winners = {}

    boards.each_with_index do |board, board_index|
      size = board.size
      winner_lines_winning_indices = []

      (0...size).each do |row|
        row_numbers = Array.new(size, -1)
        column_numbers = Array.new(size, -1)
        (0...size).each do |column|
          row_numbers[column] = board[row][column]
          column_numbers[column] = board[column][row]
        end

        if (winning_numbers & row_numbers).size == row_numbers.size
          winner_lines_winning_indices.push(get_winning_idx(winning_numbers, row_numbers))
        end

        if (winning_numbers & column_numbers).size == column_numbers.size
          winner_lines_winning_indices.push(get_winning_idx(winning_numbers, column_numbers))
        end
      end

      winners.store(board_index, winner_lines_winning_indices.min)
    end

    first_winner_data = winners.min_by { |_board_idx, winner_idx| winner_idx }
    last_winner_data = winners.max_by { |_board_idx, winner_idx| winner_idx }

    puts "problem 1 answer: #{get_solution_for_winner_data(first_winner_data, boards, winning_numbers)}" # correct answer 39902
    puts "problem 2 answer: #{get_solution_for_winner_data(last_winner_data, boards, winning_numbers)}" # correct answer 26936
  end

  def get_winning_idx(winning_numbers, wining_line)
    wining_line.map { |number| winning_numbers.index(number) }.max
  end

  def get_solution_for_winner_data(winner_data, boards, winning_numbers)
    winner_board = boards[winner_data[0]]
    winner_number = winning_numbers[winner_data[1]]
    winner_board_elements_sum = winner_board.map(&:sum).sum
    winning_numbers_till_winning_idx = winning_numbers.select { |number| winning_numbers.index(number) <= winner_data[1] }
    marked_numbers_sum = (winner_board.flatten & winning_numbers_till_winning_idx).sum
    sum_of_unmarked_numbers = winner_board_elements_sum - marked_numbers_sum
    winner_number * sum_of_unmarked_numbers
  end
end

Day4.new
