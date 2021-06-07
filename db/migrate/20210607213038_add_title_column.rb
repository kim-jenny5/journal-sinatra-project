class AddTitleColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :title, :string
  end
end
