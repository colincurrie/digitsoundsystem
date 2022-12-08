class Mixtape < ActiveRecord::Base
  MIXCLOUD_URL = /www.mixcloud.com/
  SOUNDCLOUD_URL = /www.soundcloud.com/

  include Scored

  belongs_to :user
  has_many :comments

  validates_presence_of :url

  before_save :fetch_meta_data
  before_create :initialise_score

  protected

  def fetch_meta_data
    if url =~ MIXCLOUD_URL
      response = RestClient.get url.sub('www', 'api') + 'embed-html/?width=900&height=150&color=ff0000'
      self.html = response.body if response.code == 200
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
end
