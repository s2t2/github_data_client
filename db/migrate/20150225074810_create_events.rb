class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :github_id, :limit => 8, :null => false # http://stackoverflow.com/a/6352511/670433
      t.string :event_type
      t.integer :repo_id
      t.integer :org_id
      t.boolean :public
      t.datetime :event_at

      t.timestamps null: false
    end

    add_index :events, :github_id, :unique => true
    add_index :events, :event_type
    add_index :events, :repo_id
    add_index :events, :org_id
    add_index :events, :public
    add_index :events, :event_at
  end
end
