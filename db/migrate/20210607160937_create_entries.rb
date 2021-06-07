class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.text :the_entry
      t.string :mood
      t.text :food
      t.string :gratitude
    end
  end
end
