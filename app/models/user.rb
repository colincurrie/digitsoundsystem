class User < ActiveRecord::Base
  has_many :comments
  has_many :stories
  has_many :photos
  has_many :mixtapes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
end
