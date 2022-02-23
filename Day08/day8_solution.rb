# frozen_string_literal: true

class Day8
  def initialize
    input = File.readlines('day8_input.txt').map { |line| line.split('|').map(&:strip) }.to_h
    problems_solution(input)
  end

  def problems_solution(input)
    supported_sizes = [2, 3, 4, 7]
    easy_digits_count = 0
    input.values.each do |output_array|
      output_array.split(' ').each do |output|
        easy_digits_count += 1 if supported_sizes.include?(output.size)
      end
    end

    puts "problem 1 answer: #{easy_digits_count}" # correct answer for problem 1: 452

    # build the models

    models = []

    input.keys.each do |pattern_array|
      model = {}
      patterns = pattern_array.split(' ').map { |element| element.split('') }

      number_one = patterns.find { |pattern| pattern.size == 2 }
      model.store('c', number_one[0])
      model.store('f', number_one[1])

      number_seven = patterns.find { |pattern| pattern.size == 3 }
      number_seven.each do |letter|
        if model.key(letter).nil?
          model.store('a', letter) # robust find of a
        end
      end

      number_four = patterns.find { |pattern| pattern.size == 4 }
      number_four_missing_letters = number_four.select { |letter| model.key(letter).nil? }
      model.store('b', number_four_missing_letters[0])
      model.store('d', number_four_missing_letters[1])

      number_nine = patterns.find do |pattern|
        pattern.size == 6 &&
          model.values.intersection(pattern).size == 5
      end
      number_nine.each do |letter|
        if model.key(letter).nil?
          model.store('g', letter) # robust find of g
        end
      end

      number_eight = patterns.find { |pattern| pattern.size == 7 }
      number_eight.each do |letter|
        if model.key(letter).nil?
          model.store('e', letter) # robust find of e
        end
      end

      number_two = patterns.find do |pattern|
        pattern.size == 5 &&
          pattern.include?(model['a']) &&
          pattern.include?(model['g']) &&
          pattern.include?(model['e'])
      end
      if number_two.include?(model['f']) # robust find of f and c
        temporar_f = model['f']
        model.store('f', model['c'])
        model.store('c', temporar_f)
      end

      if number_two.include?(model['b']) # robust find of b and d
        temporar_b = model['b']
        model.store('b', model['d'])
        model.store('d', temporar_b)
      end

      models.push(model)
    end

    # decode values with a help of models

    numbers_by_size = { 1 => 2, 7 => 3, 4 => 4, 8 => 7 }
    all_digits = []

    input.values.each_with_index do |output_array, output_index|
      digits = Array.new(4)
      model = models[output_index]
      output_array.split(' ').each_with_index do |output_number_code, index|
        if numbers_by_size.values.include?(output_number_code.size)
          digits[index] = numbers_by_size.key(output_number_code.size)
          next
        end

        chars = output_number_code.split('')
        missing_letters = model.values + chars - (model.values & chars)
        if missing_letters.size == 1
          digits[index] = 9 if missing_letters.first == model['e']
          digits[index] = 0 if missing_letters.first == model['d']
          digits[index] = 6 if missing_letters.first == model['c']
        end
        next unless missing_letters.size == 2

        if missing_letters.include?(model['b']) && missing_letters.include?(model['f'])
          digits[index] = 2
          end
        if missing_letters.include?(model['b']) && missing_letters.include?(model['e'])
          digits[index] = 3
          end
        if missing_letters.include?(model['c']) && missing_letters.include?(model['e'])
          digits[index] = 5
          end
      end
      all_digits.push(digits.join.to_i)
    end
    puts "problem 2 answer: #{all_digits.sum}" # correct answer for problem 2: 1096964
  end
end

Day8.new
