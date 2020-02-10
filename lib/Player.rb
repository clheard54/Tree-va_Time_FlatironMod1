class Player < ActiveRecord::Base
  has_many :players_questions
  has_many :questions, through: :players_questions
end

#CREATE a new player
def create_player(name: name = "Player 1")
    Player.create(name)
end

#READ a question
go find an entry in questions database with correct category id


#CREATE an answer

#UPDATE an answer

#UPDATE a player's available clues (by using it)