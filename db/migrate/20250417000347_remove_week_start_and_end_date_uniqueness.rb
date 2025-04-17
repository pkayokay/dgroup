class RemoveWeekStartAndEndDateUniqueness < ActiveRecord::Migration[8.0]
  def change
    remove_index :weeks, [:plan_id, :start_date, :end_date]
    add_index :weeks, [:plan_id, :start_date, :end_date], unique: false
  end
end
