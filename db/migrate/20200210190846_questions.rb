class Questions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :category_num
      t.string :choices
      t.string :correct_answer
    end
  end
end
