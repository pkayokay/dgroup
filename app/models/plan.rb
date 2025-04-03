class Plan < ApplicationRecord
  belongs_to :user

  enum :plan_type, {
    new_testament_reading_plan: 0,
    f260_reading_plan: 1,
  }

  validates :start_date, presence: true
end
