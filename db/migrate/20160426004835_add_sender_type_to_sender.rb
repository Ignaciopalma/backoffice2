class AddSenderTypeToSender < ActiveRecord::Migration
  def change
    add_column :senders, :sender_type, :integer
  end
end
