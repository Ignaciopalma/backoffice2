class CreateSenderPayStates < ActiveRecord::Migration
  def change
    create_table :sender_pay_states do |t|
      t.string :name
      t.timestamps null: false
    end
    SenderPayState.create(:name => "No pagado")
    SenderPayState.create(:name => "Pagado")
  end
end
