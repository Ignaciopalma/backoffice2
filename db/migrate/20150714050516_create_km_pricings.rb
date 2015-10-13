class CreateKmPricings < ActiveRecord::Migration
  def change
    create_table :km_pricings do |t|
      t.integer :value
      t.timestamps null: false
    end
    KmPricing.create(:value => 20)
  end
end
