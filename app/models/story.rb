class Story < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  before_validation { image.clear if @delete_image }

  validates_presence_of :title
  validates_presence_of :content

  has_attached_file :image,
                    url: '/stories/:id/:style/:basename.:extension',
                    path: ':rails_root/public/stories/:id/:style/:basename.:extension',
                    styles: {thumb: '450x150', normal: '900x300>'}
  validates_attachment :image,
                       :content_type => {:content_type => %w(image/jpeg image/png)}

  def delete_image
    @delete_image ||= false
  end

  def delete_image=(value)
    @delete_image = !value.to_i.zero?
  end
end
