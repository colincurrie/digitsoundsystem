class TunesController < ApplicationController

  DISCOGS_URL = /www.discogs.com/

  def index
    @title = 'Tunes'
    @tunes = Tune.order('updated_at desc')
  end

  def new
    @tune = Tune.new
    @action = 'add'
  end

  def edit
    @tune = Tune.find(params[:id])
    @action = 'edit'
  end

  def show
    @tune = Tune.find(params[:id])
  end

  def create
    @tune = Tune.new(tune_params)
    if @tune.save
      redirect_to tunes_path
    else
      render 'new'
    end
  end

  def update
    properties = tune_params
    @tune = Tune.find(params[:id])

    if @tune.update(properties)
      redirect_to tunes_path
    else
      render 'edit'
    end
  end

  def destroy
    @tune = Tune.find(params[:id])
    @tune.destroy
    redirect_to tunes_path
  end

  private

  def tune_params
    extended_params = {user: current_user}
    url = params[:tune][:url] rescue nil
    params.require(:tune).permit(:artist, :title, :url).merge extended_params
  end

end
