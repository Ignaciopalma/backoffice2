class DeviseCreateSenders < ActiveRecord::Migration
  def change
    create_table(:senders) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string :contact_name
      t.string :contact_email
      t.string :phone_number
      t.string :business_name
      t.string :razon_social
      t.string :rut
      t.string :giro
      t.string :address
      t.integer :area_id
      t.integer :city_id

      # cantidad de días después del envío
      t.integer :days_after, :default => 0

      # número día mes
      t.integer :pay_fixed_date, :default => 0



      t.integer :city_id

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end

    add_index :senders, :email,                unique: true
    add_index :senders, :reset_password_token, unique: true
    # add_index :senders, :confirmation_token,   unique: true
    # add_index :senders, :unlock_token,         unique: true
  end
end
