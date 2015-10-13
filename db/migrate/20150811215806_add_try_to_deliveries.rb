class AddTryToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :try, :integer, default: 1
  end
end
