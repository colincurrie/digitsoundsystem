class StoriesController < ApplicationController

  def index
    @title = 'News'
    @story ||= Story.new
    @stories = Story.order('updated_at desc')
    logger.debug "Story is #{@story}: #{params}"
  end

  def new
    @story = Story.new
  end

  def edit
    @story = Story.find(params[:id])
  end

  def show
    @story = Story.find(params[:id])
    logger.debug "Story is #{@story}: #{params}"
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      @story = nil
      redirect_to stories_path
    else
      @stories = Story.order('updated_at desc')
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

end
