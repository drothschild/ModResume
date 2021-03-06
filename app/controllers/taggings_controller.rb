class TaggingsController < ApplicationController
  # before_filter :find_tagger, only: [:create]

  def create
    tags = parse_tags_names( tagging_params[:tag_names])
    @taggings = []
    find_tagger.taggings.delete_all
    # delete_orphaned_tags
    # p tagging_params[:taggable_id]
    tags.each do |tag|
      tagging = Tagging.find_or_create_by(taggable_id: tagging_params[:taggable_id], taggable_type: tagging_params[:taggable_type], tag:tag)
      p tagging
      @taggings << tagging
    end
    render json: tags
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

  # def delete_orphaned_tags 
  #   find_tagger.user.tags.each do |tag|
  #     if tag.taggings.count == 0
  #       tag.destroy
  #     end
  #   end
  # end
  
end
