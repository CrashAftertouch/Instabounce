class Post < ActiveRecord::Base
  #Require an image for each post
  validates :image, presence: true
  validates :user_id, presence: true

  # Relationships
  belongs_to :user

  # Paperclip image upload gem setup code
  has_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
