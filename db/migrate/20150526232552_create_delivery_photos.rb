class CreateDeliveryPhotos < ActiveRecord::Migration
  def change
    create_table :delivery_photos do |t|
      t.integer :status
      t.integer :delivery_id

      t.timestamps null: false
    end
  end
end
