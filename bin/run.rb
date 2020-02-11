require_relative "../config/environment"

cli = CommandLineInterface.new
cli.greet
cli.create_player

puts "So you think you know ALL the things... Let's see what you've got!"

cli.get_question
cli.read_question

def run
  next_move = cli.break
  case next_move
  when 1
    read_question(PlayersQuestion.find_by(player_id: @player.id).last)
  when 2
    #start over
    cli.get_question
  when 3
    #calculate score
    answered = PlayersQuestion.find_by(player_id: @player.id)
    calculate(answered)
  end
end
