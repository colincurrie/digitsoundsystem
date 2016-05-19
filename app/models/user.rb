class User < ActiveRecord::Base
  has_many :comments
  has_many :stories
  has_many :photos
  has_many :mixtapes
  has_many :events

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
