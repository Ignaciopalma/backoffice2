class AddAttachmentPhotoToDeliveryPhotos < ActiveRecord::Migration
  def self.up
    change_table :delivery_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :delivery_photos, :photo
  end
end
