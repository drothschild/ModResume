class TaggingsController < ApplicationController
  before_filter :find_tagger

  def create
    p "*" * 80
    p params
    @tagging = Tagging.create(tagging_params)
    respond_to do |format|
      format.html{}
      format.json{render json: @tagging}
    end
  end

  private

  def tagging_params
    params.require(:tagging).permit(:id, :tag_id, :taggable_id, :taggable_type)
  end

  def find_tagger
    @klass = params[:tagging][:taggable_type].capitalize.singularize.constantize
    @tagger = @klass.find(params[:tagging][:taggable_id])
  end

end
