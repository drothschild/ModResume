class CreateResumeAssets < ActiveRecord::Migration
  def change
    create_table :resume_assets do |t|
      t.integer :resume_id
      t.integer :buildable_id
      t.string :buildable_type
      t.timestamps null: false
    end
  end
end
