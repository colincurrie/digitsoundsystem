class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments
  has_many :stories
  has_many :photos
  has_many :mixtapes
  has_many :events
  has_many :videos

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  after_create :user_created

  protected

  def user_created
    AdminMailer.new_user(self).deliver_later unless Rails.env == 'development'
  end
end
