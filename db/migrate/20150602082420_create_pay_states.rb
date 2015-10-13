class CreatePayStates < ActiveRecord::Migration
  def change
    create_table :pay_states do |t|
      t.string :name
      t.timestamps null: false
    end
    PayState.create(:name => "No pagado")
    PayState.create(:name => "Pagado")
  end
end
