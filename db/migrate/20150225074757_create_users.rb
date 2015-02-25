class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.integer :github_id, :null => false
      t.string :user_type
      t.string :name

      t.timestamps null: false
    end

    add_index :users, [:username, :github_id], :unique => true
    add_index :users, :username
    add_index :users, :github_id
  end
end
