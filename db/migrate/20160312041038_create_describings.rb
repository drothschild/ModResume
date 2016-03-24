class CreateDescribings < ActiveRecord::Migration
  def change
    create_table :describings do |t|
      t.integer :description_id
      t.integer :describable_id
      t.string :describable_type
      t.timestamps null: false
    end
  end
end
