class AddIvaAndVxcomissionToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :iva, :integer, default: 0
    add_column :deliveries, :vx_comission, :integer, default: 0
  end
end
