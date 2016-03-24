class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :description
      t.string :url
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
