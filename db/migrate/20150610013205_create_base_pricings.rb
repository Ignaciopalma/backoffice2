class CreateBasePricings < ActiveRecord::Migration
  def change
    create_table :base_pricings do |t|
      t.integer :value

      t.timestamps null: false
    end
    BasePricing.create(:value => 1450)
  end
end
