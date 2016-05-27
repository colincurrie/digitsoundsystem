class Story < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates_presence_of :title
  validates_presence_of :content
end
