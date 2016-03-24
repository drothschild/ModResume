class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.integer :user_id
      t.text :description
      t.timestamps null: false
    end
  end
end
