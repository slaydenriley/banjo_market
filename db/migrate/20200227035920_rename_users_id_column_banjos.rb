class RenameUsersIdColumnBanjos < ActiveRecord::Migration[5.2]
  def change
    rename_column :banjos, :users_id, :user_id
  end
end
