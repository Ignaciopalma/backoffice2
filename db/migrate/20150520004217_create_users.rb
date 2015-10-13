class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :api_key
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :rut
      t.string :address
      t.string :phone
      t.integer :bank_id
      t.integer :account_type_id
      t.string :account_number
      t.integer :occupation_id
      t.string :occupation_detail
      t.integer :active, :default => 0
      #falta agregar las validaciones a nivel de bdd, los default agregar los indices
      t.timestamps null: false
    end
  end
end
