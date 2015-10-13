class CreateAccountTypes < ActiveRecord::Migration
  def change
    create_table :account_types do |t|
      t.string :name

      t.timestamps null: false
    end
    AccountType.create(:name => "Cuenta Vista")
    AccountType.create(:name => "Cuenta Corriente")
  end
end
