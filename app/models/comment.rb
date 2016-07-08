class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :photo
  belongs_to :mixtape
  belongs_to :video
  belongs_to :event

  validates_presence_of :content

  after_create :comment_created

  def comment_created
      AdminMailer.new_comment(self).deliver_later # unless Rails.env == 'development'
  end

  def subject
    story || photo || video || mixtape || event
  end
end
