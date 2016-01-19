class MixtapesController < ApplicationController

  MIXCLOUD_URL = /www.mixcloud.com/

  def index
    @title = 'Mixtapes'
    @mixtapes = Mixtape.order('updated_at desc')
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

  private

  def mixtape_params
    extended_params = { user: curent_user }
    url = params[:mixtape][:url] rescue nil
    if MIXCLOUD_URL =~ url
      response = RestClient.get url.sub('www', 'api') + 'embed-html/?width=900&height=65&color=ff0000'
      extended_params[:html] = response.body if response.code == 200
    end
    params.require(:mixtape).permit(:title, :description, :url).merge extended_params
  end

end
