class TunesController < ApplicationController

  def index
    @title = 'Tunes'
    @tunes = Tune.order('updated_at desc').first(10)
  end

  def new
    @tune = Tune.new
  end

  def edit
    @tune = Tune.find(params[:id])
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
      redirect_to tune_path(@tune)
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
    tune_params = params.require(:tune).permit(:artist, :title, :url)

    # add the user and html
    tune_params.merge!(user: current_user)
  end

end
