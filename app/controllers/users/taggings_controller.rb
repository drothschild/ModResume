class TaggingsController < ApplicationController

  def create
    @tagging = Tagging.create(tagging_params)
  end

  private

  def tagging_params
    params.require(:tagging).permit(:id, :tag_id, :taggable_id, :taggable_type)
  end

end
