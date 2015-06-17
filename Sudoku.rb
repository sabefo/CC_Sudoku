class Sudoku

	def initialize(sudoku_string)
		@sudoku_string = sudoku_string
		@sudoku_array = @sudoku_string.split("").each_slice(9).to_a
		@box = create_box

	end

	def solve!
		puts
		puts "Inicial"
		board
		index = 0
		while index < @sudoku_string.length
			if !is_there_cero?
				puts
				puts "Final"
				board
				return
			else
				index = next_zero_coordinate(index)
				coordinate = calculate_coordinate(index)
				opciones = opciones(coordinate)
				if opciones.length != 1
					index += 1
				else
					@sudoku_string[index] = opciones.pop.to_s
					@sudoku_array[coordinate[0]][coordinate[1]] = @sudoku_string[index]
					@box = create_box
					index = 0
				end
			end
		end
	end

	def board
		@sudoku_array[0].join(" ")
		puts "-" * 21 
		@sudoku_array.each_with_index do |line, index|
			x = line.join(" ")
			puts x.slice(0, 6) + "| " + x.slice(6, 6) + "| " + x.slice(12, 6)

			if (index + 1) % 3 == 0 
				puts "-" * 21 
			end
		end
		nil
	end
	
	private

		def is_there_cero?
			@sudoku_string.include?("0")
		end

		def calculate_coordinate(i)
			if i == nil
			else
				row = i / 9
				col = i % 9
				coordinate = [row, col]
			end
		end

		def next_zero_coordinate(i)
			index = @sudoku_string.index("0", i)
		end

		def create_box
			caja_1, caja_2, caja_3, caja_4, caja_5, caja_6, caja_7, caja_8, caja_9, caja_final = [], [], [], [], [], [], [], [], [], []
			caja_1 << @sudoku_string[0..2].split(//) << @sudoku_string[9..11].split(//) << @sudoku_string[18..20].split(//)
			caja_1.flatten!
			caja_2 << @sudoku_string[3..5].split(//) << @sudoku_string[12..14].split(//) << @sudoku_string[21..23].split(//)
			caja_2.flatten!
			caja_3 << @sudoku_string[6..8].split(//) << @sudoku_string[15..17].split(//) << @sudoku_string[24..26].split(//)
			caja_3.flatten!
			caja_4 << @sudoku_string[27..29].split(//) << @sudoku_string[36..38].split(//) << @sudoku_string[45..47].split(//)
			caja_4.flatten!
			caja_5 << @sudoku_string[30..32].split(//) << @sudoku_string[39..41].split(//) << @sudoku_string[48..50].split(//)
			caja_5.flatten!
			caja_6 << @sudoku_string[33..35].split(//) << @sudoku_string[42..44].split(//) << @sudoku_string[51..53].split(//)
			caja_6.flatten!
			caja_7 << @sudoku_string[54..56].split(//) << @sudoku_string[63..65].split(//) << @sudoku_string[72..74].split(//)
			caja_7.flatten!
			caja_8 << @sudoku_string[57..59].split(//) << @sudoku_string[66..68].split(//) << @sudoku_string[75..77].split(//)
			caja_8.flatten!
			caja_9 << @sudoku_string[60..62].split(//) << @sudoku_string[69..71].split(//) << @sudoku_string[78..80].split(//)
			caja_9.flatten!

			caja_final << caja_1 << caja_2 << caja_3 << caja_4 << caja_5 << caja_6 << caja_7 << caja_8 << caja_9
		end
	
		def in_array(array)
			taken_numbers = []
			array.each do |number|
				if number != "0"
					taken_numbers << number
				end
			end
			taken_numbers
		end

		def in_box(box)
			in_array(@box[box])
		end

		def which_box(coordinate)
			row = coordinate[0]
			col = coordinate[1]
			case row
			when 0..2
				case col
				when 0..2
						box = in_box(0)
				when 3..5
						box = in_box(1)
				else
						box = in_box(2)
				end
			when 3..5
				case col
				when 0..2
						box = in_box(3)
				when 3..5
						box = in_box(4)
				else
						box = in_box(5)
				end
			else
				case col
				when 0..2
						box = in_box(6)
				when 3..5
						box = in_box(7)
				else
						box = in_box(8)
				end
			end
		end
	
		def in_row(row)
			in_array(@sudoku_array[row])
		end

		def in_column(col)
			transpuesta = @sudoku_array.transpose
			in_array(transpuesta[col])
		end

		def opciones(coordinate)
			row = coordinate[0]
			col = coordinate[1]
			in_row = in_row(row)
			in_column = in_column(col)
			in_box = which_box(coordinate)
			options = in_box + in_column + in_row
			options.uniq!
			complement = []
			for i in 1...10
				if !options.include?(i.to_s)
					complement << i
				end
			end
			complement
		end
end

game = Sudoku.new('702806519100740230005001070008000002610204053200000100070400800064078005821503907')
#game.board

game.solve!
#puts game.opciones([3,6])
