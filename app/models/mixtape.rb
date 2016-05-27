class Mixtape < ActiveRecord::Base
  MIXCLOUD_URL = /www.mixcloud.com/
  SOUNDCLOUD_URL = /www.soundcloud.com/

  belongs_to :user
  has_many :comments

  include Scored

  validates_presence_of :url

  before_create :initialise_score
  before_save :fetch_meta_data

  def html
    # work out the embedded html from the url
    if url =~ MIXCLOUD_URL
      response = RestClient.get url.sub('www', 'api') + 'embed-html/?width=900&height=150&color=ff0000'
      response.body if response.code == 200
    end
  end

  protected

  def fetch_meta_data
    if title.nil? || description.nil?
      response = RestClient.get url.sub('www', 'api')
      if response.code == 200
        data = JSON.parse(response.body)
        self.title = data['name'] if title.nil? || title.empty?
        self.description = data['description'] if description.nil? || description.empty?
      end
    end
  end
end
