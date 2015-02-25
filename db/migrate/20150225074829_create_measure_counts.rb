class CreateMeasureCounts < ActiveRecord::Migration
  def change
    create_table :measure_counts do |t|
      t.integer :user_id, :null => false
      t.string :metric_name, :null => false
      t.string :period_name, :null => false
      t.integer :measure_value

      t.timestamps null: false
    end

    add_index :measure_counts, [:user_id, :metric_name, :period_name], :unique => true
    add_index :measure_counts, :user_id
    add_index :measure_counts, :metric_name
    add_index :measure_counts, :period_name
  end
end
