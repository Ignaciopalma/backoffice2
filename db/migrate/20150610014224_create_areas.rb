class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.timestamps null: false
    end
    Area.create(:name => "Santiago")
    Area.create(:name => "Cerrillos")
    Area.create(:name => "Cerro Navia")
    Area.create(:name => "Conchalí")
    Area.create(:name => "El Bosque")
    Area.create(:name => "Estación Central")
    Area.create(:name => "Huechuraba")
    Area.create(:name => "Independencia")
    Area.create(:name => "La Cisterna")
    Area.create(:name => "La Florida")
    Area.create(:name => "La Granja")
    Area.create(:name => "La Pintana")
    Area.create(:name => "La Reina")
    Area.create(:name => "Las Condes")
    Area.create(:name => "Lo Barnechea")
    Area.create(:name => "Lo Espejo")
    Area.create(:name => "Lo Prado")
    Area.create(:name => "Macul")
    Area.create(:name => "Maipú")
    Area.create(:name => "Ñuñoa")
    Area.create(:name => "Pedro Aguirre Cerda")
    Area.create(:name => "Peñalolén")
    Area.create(:name => "Providencia")
    Area.create(:name => "Pudahuel")
    Area.create(:name => "Quilicura")
    Area.create(:name => "Quinta Normal")
    Area.create(:name => "Recoleta")
    Area.create(:name => "Renca")
    Area.create(:name => "San Joaquín")
    Area.create(:name => "San Miguel")
    Area.create(:name => "San Ramón")
    Area.create(:name => "Vitacura")
  end
end
