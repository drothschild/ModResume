class AddUserSortToResumeAssets < ActiveRecord::Migration
  def change
    add_column :resume_assets, :user_sort, :integer, default: 0
  end
end
