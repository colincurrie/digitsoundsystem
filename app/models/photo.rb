class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_attached_file :image,
                url: '/assets/images/:id/:style/:basename.:extension',
                path: ':rails_root/public/assets/images/:id/:style/:basename.:extension',
                styles: {
                  small: '150x150#',
                  medium: '300x300#',
                  landscape: '300x150#',
                  portrait: '150x300#'
                }

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)
end
