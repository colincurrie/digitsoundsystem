class StoriesController < ApplicationController

  def index
    @title = 'News'
    @story ||= Story.new
    @stories = stories
  end

  def new
    @story = Story.new
  end

  def edit
    @story = Story.find(params[:id])
  end

  def show
    @story = Story.find(params[:id])
    @comments = @story.comments.page(page).per_page(per_page)
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      @story = nil
      redirect_to stories_path
    else
      @stories = stories
      render :index
    end
  end

  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      @story = nil
      redirect_to stories_path
    else
      render 'edit'
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_path
  end

  def remove_image
    Story.find(params[:id]).image.destroy
    redirect_to request.referer
  end

  private

  def story_params
    params.require(:story).permit(:title, :content, :image, :image_position).merge user: current_user
  end

  def admin?
    current_user.try(:admin?)
  end

  def stories
    Story.order('created_at DESC').page(page).per_page(per_page)
  end
end
