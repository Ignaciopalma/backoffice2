class CreateAvailableAreas < ActiveRecord::Migration
  def change
    create_table :available_areas do |t|
      t.string :name

      t.timestamps null: false
    end
    AvailableArea.create(:name => "Providencia")
    AvailableArea.create(:name => "Las Condes")
    AvailableArea.create(:name => "Santiago")
    AvailableArea.create(:name => "Vitacura")
    AvailableArea.create(:name => "La Florida")
    AvailableArea.create(:name => "Lo Prado")
    AvailableArea.create(:name => "Quinta Normal")
    AvailableArea.create(:name => "Recoleta")
    AvailableArea.create(:name => "Estación Central")
    AvailableArea.create(:name => "San Joaquín")
  end
end
