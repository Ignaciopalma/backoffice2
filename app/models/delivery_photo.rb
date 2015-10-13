class DeliveryPhoto < ActiveRecord::Base
  belongs_to :delivery
  has_attached_file :photo
  #validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates_attachment_size :photo, :less_than => 50.megabytes
end
