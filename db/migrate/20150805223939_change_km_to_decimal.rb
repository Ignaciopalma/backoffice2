class ChangeKmToDecimal < ActiveRecord::Migration
  def self.up
    change_column :deliveries, :km, :decimal
  end
  def self.down
    change_column :deliveries, :km, :integer
  end
end
