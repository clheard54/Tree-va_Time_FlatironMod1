class Players < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.float :score = nil
      t.string :judgment = nil
    end
  end
end
