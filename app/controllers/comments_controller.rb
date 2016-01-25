class CommentsController < ApplicationController

  def create
    parent, path = parent_and_path
    @comment = parent.comments.create(comment_params) if parent
    redirect_to path
  end

  def destroy
    parent, path = parent_and_path
    @comment = parent.comments.find(params[:id])
    @comment.destroy
    redirect_to path
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge user: current_user
  end

  def parent_and_path
    if params[:story_id]
      parent = Story.find(params[:story_id])
      path = stories_path
    elsif params[:photo_id]
      parent = Photo.find(params[:photo_id])
      path = photo_path parent
    elsif params[:mixtape_id]
      parent = Mixtape.find(params[:mixtape_id])
      path = mixtapes_path
    else
      parent = nil
      path = root_path
    end
    [parent, path]
  end
end
