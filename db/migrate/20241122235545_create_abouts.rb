class CreateAbouts < ActiveRecord::Migration[8.0]
  def change
    create_table :abouts do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :firstname
      t.string :lastname
      t.string :marital_status
      t.boolean :have_children
      t.string :education
      t.string :location
      t.string :goal
      t.string :ethnicity
      t.decimal :height, precision: 5, scale: 2
      t.string :body_type

      t.timestamps
    end
  end
end
