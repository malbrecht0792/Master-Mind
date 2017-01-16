# Things we need

# Game
# Player
# Board
# Logic to choose to be the code creator or not
# Turns

# Need to add winning logic
# Need to add out of turns logic
# Maybe add invalid input statement


class Game

	def initialize(player_name)
		@player = Player.new(player_name)
		@board = Board.new
		generate_ai_code
		@board.display_board
		@continue_game = true
		@turn_number = 1
		game_loop
	end

	def generate_ai_code
		@ai_code = ""
		4.times do
			@ai_code = @ai_code + ["W","P","Y","G","R","B"].sample
		end
		@AI_code_constant = @ai_code.clone
	end

	def game_loop
		while @continue_game
			turn
		end
	end

	def turn
		#puts "ai_code: #{@AI_code_constant}"
		puts "#{@player.name}, please select 4 pegs of the following six (W,P,Y,G,R,B)"
		@move = gets.chomp
		#Check input
		input_check
		#Reset ai_code
		reset_ai_code
		#Call update board
		@board.update_board(@turn_number, @move, @ai_code)
		#Call display board
		@board.display_board
		@turn_number += 1
		#Call the game_over? method
		game_over?
	end

	def reset_ai_code
		@ai_code = @AI_code_constant.dup
	end

	def input_check
		unless @move[/[A-Z]{4}/] == @move
			puts "Invalid selection of pegs!"
			puts "#{@player.name}, please select 4 pegs of the following six (W,P,Y,G,R,B)"
			@move = gets.chomp
			#Check input
			input_check
		end
	end

	def game_over?
		if @board.number_of_black_pegs == 4
			puts "You guessed the secret code, you win!"
			@continue_game = false
		elsif @turn_number == 13
			puts "You're out of turns, game over!"
			@continue_game = false
		end
	end

end

class Player
	attr_accessor :name

	def initialize(name)
		@name = name
	end
end

class Board

	attr_accessor :pegs, :board_array, :number_of_black_pegs

	def initialize
		@number_of_black_pegs = 0
		@number_of_white_pegs = 0
		@pegs = ["W","P","Y","G","R","B","w","b"]
		@board_array = []
		12.times do |x|
			@board_array << [12-x," * ", " * ", " * ", " * ","   ", " - "," - "," - "," - "]
		end
	end

	def display_board
		@board_array.each do |line|
			p line.join
		end
	end

	def update_board(turn_number, move, ai_code)

		#Update the board with the current move
		4.times do |x|
			@board_array[12-turn_number][6 + x] = " " + move[x] + " "
		end
		
		initialize_black_and_white_pegs
		4.times do |i|
			if move[i] == ai_code[i]
				@number_of_black_pegs += 1
				move[i] = " "
				ai_code[i] = " "
			end
		end

		4.times do |j|
			if ai_code.include?(move[j]) && move[j] != " "
				ai_code.sub(move[j], " ")
				@number_of_white_pegs += 1
			end
		end

		#Update the number of black and white pegs

		@number_of_black_pegs.times do |peg|
			@board_array[12-turn_number][peg + 1] = " b "
		end
			
		@number_of_white_pegs.times do |peg|
			@board_array[12-turn_number][@number_of_black_pegs + peg + 1] = " w "
		end

	end

	def initialize_black_and_white_pegs
		@number_of_black_pegs = 0
		@number_of_white_pegs = 0
	end

end

my_game = Game.new("Marcel")



