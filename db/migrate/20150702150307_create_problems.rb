class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :user_id
      t.string :content

      t.timestamps null: false
    end
  end
end
