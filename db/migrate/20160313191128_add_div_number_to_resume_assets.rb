class AddDivNumberToResumeAssets < ActiveRecord::Migration
  def change
    add_column :resume_assets, :div_sort, :integer, default: 0
  end
end
