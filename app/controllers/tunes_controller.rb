class TunesController < ApplicationController

  SOUNDCLOUD_URL = /soundcloud.com/
  YOUTUBE_URL = /www.youtube.com/
  DISCOGS_URL = /www.discogs.com/
  JUNO_URL = /www.juno.co.uk/


  def index
    @title = 'Tunes'
    @tunes = Tune.scored.page(params.fetch('page',1)).per_page(params.fetch('per_page',10))
    @total = Tune.count
  end

  def new
    authenticate
    @tune = Tune.new
  end

  def edit
    authenticate
    @tune = Tune.find(params[:id])
  end

  def show
    @tune = Tune.find(params[:id])
    @comments = @tune.comments.page(page).per_page(per_page)
  end

  def create
    authenticate
    @tune = Tune.new(tune_params)
    if @tune.save
      redirect_to tunes_path
    else
      render 'new'
    end
  end

  def update
    @tune = Tune.find(params[:id])
    authenticate tune_path(@tune)

    if @tune.update(tune_params)
      redirect_to tune_path(@tune)
    else
      render 'edit'
    end
  end

  def destroy
    authenticate
    @tune = Tune.find(params[:id])
    @tune.destroy
    redirect_to tunes_path
  end

  def move_up
    authenticate
    Tune.find(params[:id]).move_up
    redirect_to tunes_path
  end

  def move_down
    authenticate
    Tune.find(params[:id]).move_down
    redirect_to tunes_path
  end

  private

  def authenticate(path=nil)
    redirect_to(path||tunes_path) unless current_user.try(:admin?)
  end

  def tune_params
    tune_params = params.require(:tune).permit(:artist, :title, :url)

    # work out the embedded html from the url
    html = ''
    if tune_params[:url] =~ YOUTUBE_URL
      if tune_params[:html].nil? || tune_params[:html].empty?
        youtube_id = tune_params[:url].split('=').last
        tune_params[:html] = "<iframe src=\"http://www.youtube.com/embed/#{youtube_id}\"></iframe>"
      else
        Rails.logger.debug 'TODO: scrape the artist & title if possible'
      end
    elsif tune_params[:url] =~ SOUNDCLOUD_URL
      response = RestClient.get( 'http://soundcloud.com/oembed?url=' + URI.encode(tune_params[:url]) + '&format=json')
      if response.code == 200
        data = JSON.parse(response.body)
        title, artist = data['title'].split(' by ')
        tune_params[:title] = title if tune_params[:title].nil? || tune_params[:title].empty?
        tune_params[:artist] = artist if tune_params[:artist].nil? || tune_params[:artist].empty?
        tune_params[:html] = data['html'].gsub!(/height="400"/, 'height="150"') if tune_params[:html].nil? || tune_params[:html].empty?
        Rails.logger.debug "tune_params: #{tune_params}"
      end
    end
    Rails.logger.debug "html: #{html}"

    # add the user and html
    tune_params.merge!(user: current_user)
  end

end
