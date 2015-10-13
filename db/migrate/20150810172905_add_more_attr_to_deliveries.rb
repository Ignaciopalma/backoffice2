class AddMoreAttrToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :more_info, :text, default: nil
    add_column :deliveries, :department_number, :integer, default: nil
    add_column :deliveries, :both_ways, :boolean, default: false
    add_column :deliveries, :location_type, :string, default: 'casa'
  end
end
