#Flashcard class
class Flashcard
	attr_reader :definition, :term
	# attr_writer :complete
	def initialize(definition, term)
		@definition = definition
		@term = term
		# @complete = false
	end

	# def complete?
	# 	@complete
	# end

	# def complete!
	# 	@complete = true
	# end
end

class FlashcardStack
	def initialize
		@stack = []
		@finish = false
	end

	def add_flashcard(flashcard)
		@stack << flashcard
	end

	def add_file(file)
		definition = ""
		term = ""
		File.open(file) do |f|
			line_count = 0
		  f.each_line do |line|
		  	# puts line_count
			case line_count % 3
			when 0
				definition = line
				# puts definition
			when 1
				term = line.gsub("\n","")
				# puts term
				flashcard = Flashcard.new(definition, term)
				add_flashcard(flashcard)
				# puts flashcard.complete?
			end
				


			line_count += 1
		  end
		  # puts @stack.inspect
		end
	end

	def get_random_card
		@stack.sample
		# tempflashcard.complete!
	end

	def remove_card!(flashcard)
		@stack.delete(flashcard)
	end

	def length
		@stack.length
	end
end


class Game

	def self.run
		flashcard_stack = FlashcardStack.new

		flashcard_stack.add_file("flashcard_samples.txt")

		puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition. Ready?\nGo! \n\n"

		correct_count = 0
		while flashcard_stack.length > 0
			flashcard = flashcard_stack.get_random_card

			puts "#{correct_count}/#{flashcard_stack.length} correct \nDefinition: \n#{flashcard.definition}"
			begin 
				print "Guess: "
				answer = gets.chomp
				if answer.downcase == flashcard.term.downcase
					puts "Correct!\n\n"
					correct_count += 1
				else
					puts "Incorrect! Try again.\n\n"
				end
			end until answer.downcase == flashcard.term.downcase

			flashcard_stack.remove_card!(flashcard)
		end

		puts "All flashcards have been answered correctly. =)\nThe End"
	end
end

Game.run
