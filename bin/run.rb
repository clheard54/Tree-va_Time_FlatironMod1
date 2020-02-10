require_relative "../config/environment"

cli = CommandLineInterface.new
cli.greet
cli.create_player

puts "So you think you know ALL the things... Let's see what you've got!"

cli.get_question

Question.books
1
