class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_attached_file :image,
                url: '/gallery/:id/:style/:basename.:extension',
                path: ':rails_root/public/gallery/:id/:style/:basename.:extension',
                styles: {
                  small: '150x150#',
                  landscape: '300x150#',
                  portrait: '150x300#',
                  large: '300x300#',
                  original: '900x'
  }

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/png)

  public

  def to_s
    '%d, %0.10s, %d, %s' % [id, description, score, created_at.strftime('%Y%m%d %H%M%S')]
  end
end
