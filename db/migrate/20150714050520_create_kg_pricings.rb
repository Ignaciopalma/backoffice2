class CreateKgPricings < ActiveRecord::Migration
  def change
    create_table :kg_pricings do |t|
      t.integer :value
      t.timestamps null: false
    end
    KgPricing.create(:value => 30)
  end
end
