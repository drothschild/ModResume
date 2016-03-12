class TaggingsController < ApplicationController
  before_filter :find_tagger

  def create
    @tagging = Tagging.create(tagging_params)
  end

  private

  def tagging_params
    params.require(:tagging).permit(:id, :tag_id, :taggable_id, :taggable_type)
  end

  def find_tagger
    @klass = params[:commenter_type].capitalize.constantize
    @tagger = klass.find(params[:tagger_id])
  end

end
