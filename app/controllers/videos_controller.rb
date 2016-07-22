class VideosController < ApplicationController

  def index
    @title = 'Videos'
    @videos = Video.scored.page(params.fetch('page', 1)).per_page(params.fetch('per_page',10))
    @total = Video.count
  end

  def new
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def show
    @video = Video.find(params[:id])
    @comments = @video.comments.page(page).per_page(per_page)
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_path
    else
      render 'new'
    end
  end

  def update
    properties = video_params
    @video = Video.find(params[:id])

    if @video.update(properties)
      redirect_to video_path(@video)
    else
      render 'edit'
    end
  end

  def destroy
    Video.find(params[:id]).destroy
    redirect_to videos_path
  end

  def move_up
    Video.find(params[:id]).move_up
    redirect_to videos_path
  end

  def move_down
    Video.find(params[:id]).move_down
    redirect_to videos_path
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :url).merge!(user: current_user)
  end

end
