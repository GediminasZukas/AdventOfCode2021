class Day5
	def initialize
		input = File.readlines("day5_input.txt")
		problems_solution(input)
	end	

	def problems_solution(input)
		lines = input
			.map { |row| row.split(" -> ") }			
			.map { |array|
				array[0] = array[0].split(",").map(&:strip).map(&:to_i)
				array[1] = array[1].split(",").map(&:strip).map(&:to_i)
				array
			}	

		valid_overlaps = 0

		# Hash table of rows (y coordinates). Each row is a hashtable too (x coordinate (key) and amount of occurrences (value))
		diagram = Hash.new

		lines.each do |line|
			line_start = line[0]
			line_end = line[1]	

			if line_start[1] == line_end[1] # horizontal line
				y = line_start[1]
				diagram_row = diagram[y] || Hash.new
				x1 = line_start[0]
				x2 = line_end[0]
				min = [x1, x2].min
				max = [x1, x2].max
				for i in min..max					
					times_covered = diagram_row[i] || 0
					times_covered += 1
					valid_overlaps += 1 if times_covered == 2					
					diagram_row.store(i, times_covered)					
				end
				diagram.store(y, diagram_row)	
			elsif line_start[0] == line_end[0]  # vertical line
				x = line_start[0]	
				y1 = line_start[1]
				y2 = line_end[1]
				min = [y1, y2].min
				max = [y1, y2].max
				for i in min..max
					diagram_row = diagram[i] || Hash.new
					times_covered = diagram_row[x] || 0
					times_covered += 1
					valid_overlaps += 1 if times_covered == 2					
					diagram_row.store(x, times_covered)
					diagram.store(i, diagram_row)
				end				
			else # diagonal line
				y1 = line_start[1]
				y2 = line_end[1]
				min = [y1, y2].min
				max = [y1, y2].max
				x1 = line_start[0]
				x2 = line_end[0]
				next_x = -1
				x_incrementing = false
				if y1 < y2
					next_x = x1
					x_incrementing = true if x1 < x2
				else
					next_x = x2
					x_incrementing = true if x2 < x1
				end										
				for i in min..max
					diagram_row = diagram[i] || Hash.new
					times_covered = diagram_row[next_x] || 0
					times_covered += 1
					valid_overlaps += 1 if times_covered == 2					
					diagram_row.store(next_x, times_covered)
					diagram.store(i, diagram_row)
					if (x_incrementing)
						next_x = next_x + 1 
					else 
						next_x = next_x - 1 
					end
				end					
			end
		end
		puts "problem 2 answer: #{valid_overlaps}. Comment diagonal branch to get answer for problem 1." # problem 1 answer - 6311, problem 2 answer - 19929
	end		
end

Day5.new
