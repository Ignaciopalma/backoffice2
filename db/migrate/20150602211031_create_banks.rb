class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.timestamps null: false
    end
    Bank.create(:id => 1, :name => "Banco de Chile")
    Bank.create(:id => 2, :name => "Banco Santander")
    Bank.create(:id => 3, :name => "Scotiabank")
    Bank.create(:id => 4, :name => "BBVA")
    Bank.create(:id => 5, :name => "Banco Edwards | Citi")
    Bank.create(:id => 6, :name => "BancoEstado")
    Bank.create(:id => 7, :name => "BCI")
    Bank.create(:id => 8, :name => "Banco del desarrollo")
    Bank.create(:id => 9, :name => "BanCondell")
    Bank.create(:id => 10, :name => "Banefe")
    Bank.create(:id => 11, :name => "Itau")
    Bank.create(:id => 12, :name => "Corpbanca")

  end
end
