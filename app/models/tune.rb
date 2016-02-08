class Tune < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates_presence_of :artist
  validates_presence_of :title

  def after_create
    self.order = self.created_at
  end
end
