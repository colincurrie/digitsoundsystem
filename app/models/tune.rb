class Tune < ActiveRecord::Base

  SOUNDCLOUD_URL = /soundcloud.com/
  YOUTUBE_URL = /www.youtube.com/
  DISCOGS_URL = /www.discogs.com/
  JUNO_URL = /www.juno.co.uk/

  include Scored

  belongs_to :user
  has_many :comments

  validates_presence_of :artist
  validates_presence_of :title
  before_create :initialise_score


  def initialize(params = {})
    super params
    build_html
  end

  def after_create
    self.order = created_at
  end

  private

  def build_html
    # work out the embedded html from the url
    if url =~ YOUTUBE_URL
      if html.blank?
        youtube_id = url.split('=').last
        self.html = "<iframe src=\"http://www.youtube.com/embed/#{youtube_id}\"></iframe>"
      else
        Rails.logger.debug 'TODO: scrape the artist & title if possible'
      end
    elsif url =~ SOUNDCLOUD_URL
      response = RestClient.get('http://soundcloud.com/oembed?url=' + URI.encode(self.url) + '&format=json')
      if response.code == 200
        data = JSON.parse(response.body)
        new_title, new_artist = data['title'].split(' by ')
        self.title = new_title if title.blank?
        self.artist = new_artist if artist.blank?
        self.html = data['html'].gsub!(/height="400"/, 'height="150"') if html.blank?
      end
    end
  end
end
