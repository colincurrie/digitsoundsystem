class CommentsController < ApplicationController

  def create
    parent, path = parent_and_path
    if parent
      @comment = parent.comments.create(comment_params)
      parent_class = parent.class.to_s.downcase
      url_params = request.referrer =~ /#{parent_class.pluralize}\/\d+$/ ? '' : "##{parent_class}_#{parent.id}"
    else
      url_params = ''
    end
    redirect_to request.referer + url_params
  end

  def destroy
    parent, path = parent_and_path
    @comment = parent.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
    redirect_to path
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge user: current_user
  end

  def parent_and_path
    parent_key = params.keys.select { |k| k=~/_id$/ }.first
    if parent_key
      parent_class = parent_key.scan(/(.*)_id$/).flatten.first.capitalize.constantize
      parent = parent_class.find(params[parent_key])
      path = self.send(parent_key.gsub('_id', '_path'), parent)
      #path = self.send(parent_key.gsub('_id', 's_path'))
    end
    [parent, path]
  end
end
