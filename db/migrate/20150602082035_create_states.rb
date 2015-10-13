class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.timestamps null: false
    end
    State.create(:name => "Disponible")
    State.create(:name => "Camino a retirar envío")
    State.create(:name => "En ruta a entregar envío")
    State.create(:name => "Entrega exitosa")
    State.create(:name => "Entrega fallida")
  end
end
