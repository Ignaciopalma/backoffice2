class AddServiceTypeToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :service_type, :string
  end
end
