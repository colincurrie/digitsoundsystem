class Tune < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  def after_create
    self.order = self.created_at
  end
end
