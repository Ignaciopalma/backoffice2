class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :name

      t.timestamps null: false
    end
    Occupation.create(:name => "Desempleado")
    Occupation.create(:name => "Estudiante Secundaria")
    Occupation.create(:name => "Estudiante Universitario")
    Occupation.create(:name => "Profesional")
  end
end
