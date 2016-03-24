class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :company
      t.string :title
      t.date :begin_date
      t.date :end_date
      t.text :description
      t.string :location
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
