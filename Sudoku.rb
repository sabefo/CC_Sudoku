class Sudoku

	def initialize(sudoku_string)
		@sudoku_string = sudoku_string
		@sudoku_array = @sudoku_string.split("").each_slice(9).to_a
		
	end

	def solve!
		puts "hola"
		
	end
	
	def board
		print @sudoku_array
	end

	private
	def hay_ceros()
		
	end


end

game = Sudoku.new('702806519100740230005001070008000002610204053200000100070400800064078005821503907')
game.solve!

puts game.board