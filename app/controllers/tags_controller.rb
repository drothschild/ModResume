class TagsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @tags = @user.tags.order("name")
    render partial: 'buttons', locals: {tags: @tags}
  end
  def create
    @tag = Tag.create(tag_params)
    @tags = Tag.all
    respond_to do |format|
      format.html {redirect_to '/assets'}
      format.json {render json: @tags}
    end

  end

  private

  def tag_params
    params.require(:tag).permit(:name, :user_id)
  end
end
