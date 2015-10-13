class CreatePricings < ActiveRecord::Migration
  def change
    create_table :pricings do |t|
      t.string :percentage

      t.timestamps null: false
    end
    Pricing.create(:percentage => 90)
  end
end
