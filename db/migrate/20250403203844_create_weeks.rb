class CreateWeeks < ActiveRecord::Migration[8.0]
  def change
    create_table :weeks do |t|
      t.references :plan, null: false, foreign_key: true
      t.integer :position, null: false
      t.jsonb :chapters_data, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.jsonb :memory_verse_data, null: false
      t.timestamps
    end

    add_index :weeks, [:plan_id, :position], unique: true
    add_index :weeks, [:plan_id, :start_date, :end_date], unique: true
  end
end
