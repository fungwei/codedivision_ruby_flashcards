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
				term = line
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
		@stack.delte(flashcard)
	end

end


class Game

	def self.run
		flashcard_stack = FlashcardStack.new

		flashcard_stack.add_file("flashcard_samples.txt")

		flashcard = flashcard_stack.get_random_card

		puts flashcard.definition
		puts flashcard.

		flashcard_stack.remove_card!(flashcard)
	end
end

Game.run
