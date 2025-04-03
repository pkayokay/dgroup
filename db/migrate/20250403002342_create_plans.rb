class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.integer :plan_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
