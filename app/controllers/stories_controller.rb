class StoriesController < ApplicationController

  DEFAULT_PER_PAGE = 10

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

  private

  def story_params
    params.require(:story).permit(:title, :content).merge user: current_user
  end

  def admin?
    current_user.try(:admin?)
  end

  def stories
    Story.order('created_at DESC').page(page).per_page(per_page)
  end

  def page
    params.fetch('page', 1)
  end

  def per_page
    params.fetch('per_page', DEFAULT_PER_PAGE)
  end
end
