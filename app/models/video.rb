class Video < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :title, :url

  def html
    unless url.empty?
      youtube_id = url.split('=').last
      "<iframe src=\"http://www.youtube.com/embed/#{youtube_id}\"></iframe>"
    end
  end

end
