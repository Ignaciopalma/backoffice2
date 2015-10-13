class AddPayDayToSenders < ActiveRecord::Migration
    def change
      add_column :senders, :pay_day, :integer, default: 0
  end
end
