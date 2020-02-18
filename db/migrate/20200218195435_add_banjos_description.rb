class AddBanjosDescription < ActiveRecord::Migration[5.2]
  def change
    add_column :banjos, :description, :string
  end
end
