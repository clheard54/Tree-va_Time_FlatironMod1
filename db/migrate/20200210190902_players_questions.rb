class PlayersQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :players_questions do |t|
      t.integer :player_id
      t.integer :question_id
      t.string :chosen_answer = nil
      t.timestamp
    end
  end
end
