class Video < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :title, :url

  before_save :update_score

  def html
    unless url.empty?
      youtube_id = url.split('=').last
      "<iframe src=\"http://www.youtube.com/embed/#{youtube_id}\"></iframe>"
    end
  end

  protected

  def update_score
    self.score = self.created_at || Time.now
  end
end
