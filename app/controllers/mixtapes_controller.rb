class MixtapesController < ApplicationController

  def index
    @title = 'Mixtapes'
    @mixtapes = Mixtape.scored.page(params.fetch('page',1)).per_page(params.fetch('per_page',10))
  end

  def new
    @mixtape = Mixtape.new
    @action = 'add'
  end

  def edit
    @mixtape = Mixtape.find(params[:id])

    @action = 'edit'
  end

  def show
    @mixtape = Mixtape.find(params[:id])
  end

  def create
    @mixtape = Mixtape.new(mixtape_params)
    if @mixtape.save
      redirect_to mixtapes_path
    else
      render 'new'
    end
  end

  def update
    properties = mixtape_params
    @mixtape = Mixtape.find(params[:id])
    if @mixtape.update(properties)
      redirect_to mixtapes_path
    else
      render 'edit'
    end
  end

  def destroy
    @mixtape = Mixtape.find(params[:id])
    @mixtape.destroy
    redirect_to mixtapes_path
  end

  def move_up
    Mixtape.find(params[:id]).move_up
    redirect_to mixtapes_path
  end

  def move_down
    Mixtape.find(params[:id]).move_down
    redirect_to mixtapes_path
  end

  private

  def mixtape_params
    params.require(:mixtape).permit(:title, :description, :url).merge user: current_user
  end

end
