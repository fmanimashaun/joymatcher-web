class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :liker, null: false, foreign_key: { to_table: :users }
      t.references :likee, null: false, foreign_key: { to_table: :users }
      t.integer :status

      t.timestamps
    end

    add_index :likes, [:liker_id, :likee_id], unique: true
  end
end
