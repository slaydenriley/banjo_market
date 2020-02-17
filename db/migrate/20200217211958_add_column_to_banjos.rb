class AddColumnToBanjos < ActiveRecord::Migration[5.2]
  def change
    add_column :banjos, :users_id, :integer
  end
end
