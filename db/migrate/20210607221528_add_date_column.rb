class AddDateColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :date, :date
  end
end
