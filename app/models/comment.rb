class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :photo
  belongs_to :mixtape

  validates_presence_of :content
end
