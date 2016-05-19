class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :photo
  belongs_to :mixtape
  belongs_to :video
  belongs_to :event

  validates_presence_of :content
end
