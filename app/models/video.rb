class Video < ActiveRecord::Base

  include Scored

  belongs_to :user
  has_many :comments

  validates_presence_of :title, :url
  before_create :initialise_score

  def html
    unless url.empty?
      youtube_id = url.split('=').last
      "<iframe src=\"http://www.youtube.com/embed/#{youtube_id}\"></iframe>"
    end
  end
end
