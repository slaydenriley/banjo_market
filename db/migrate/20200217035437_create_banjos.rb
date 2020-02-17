class CreateBanjos < ActiveRecord::Migration
  def change
    create_table :banjos do |t|
      t.string :make
      t.string :model
      t.integer :year_made
      t.string :price
    end
  end
end
