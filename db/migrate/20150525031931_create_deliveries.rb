class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.integer :sender_id
      t.integer :user_id, :nullable => true
      t.integer :eta
      t.integer :km
      t.integer :state_id, :default => 1
      t.integer :pay_state_id, :default => 1
      t.integer :sender_pay_state_id, :default => 1
      t.string :comuna_start
      t.string :comuna_finish
      t.decimal :lat_start
      t.decimal :long_start
      t.decimal :lat_finish
      t.decimal :long_finish
      t.decimal :peso_neto
      t.decimal :ancho
      t.decimal :largo
      t.decimal :alto
      t.integer :cost
      t.string :photo_id
      t.string :address_start
      t.string :address_finish
      t.integer :comission
      t.integer :confirmed, :default => 0
      t.datetime :pay_date
      t.string :destinatary_name
      t.string :destinatary_email

      t.timestamps null: false
    end

    add_foreign_key :deliveries, :users, column: :sender_id
    add_foreign_key :deliveries, :users, column: :user_id
    add_index :deliveries, :user_id
    add_index :deliveries, :sender_id
  end
end


