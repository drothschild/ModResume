class TaggingsController < ApplicationController
  # before_filter :find_tagger, only: [:create]

  def create
    @tagging = Tagging.new(taggable_id: tagging_params[:taggable_id], taggable_type: tagging_params[:taggable_type])
    @tag = Tag.find_by("name = ?", tagging_params[:tag_names])
    @tagging.tag = @tag
    @tagging.save
    render json: @tagging
  end

  def destroy
    @tagging=Tagging.find(params[:id])
    @tagging.destroy
    respond_to do |format|
      format.html{}
      format.json{ render :nothing => true}
    end
  end

  private

  def tagging_params
    params.require(:tagging).permit(:id, :tag_id, :tag_names, :taggable_id, :taggable_type)
  end

  def find_tagger
    @klass = params[:tagging][:taggable_type].capitalize.singularize.constantize
    @tagger = @klass.find(params[:tagging][:taggable_id])
  end

end
