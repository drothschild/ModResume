class CreateVolunteerings < ActiveRecord::Migration
  def change
    create_table :volunteerings do |t|
      t.string :organization
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
