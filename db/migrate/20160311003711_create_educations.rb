class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :institution_name
      t.string :location
      t.date :completion
      t.string :focus
      t.text :description
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
