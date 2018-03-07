class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  include Scored

  before_create :initialise_score

  has_attached_file :image,
                styles: {
                  small: '150x150#',
                  landscape: '300x150#',
                  portrait: '150x300#',
                  large: '300x300#',
                  original: '900x'
                }

  validates_attachment_presence :image
  # validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)
end
