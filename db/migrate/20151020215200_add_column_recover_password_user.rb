class AddColumnRecoverPasswordUser < ActiveRecord::Migration
  def change
    add_column :users, :recover_password_token, :string, default: nil
  end
end
