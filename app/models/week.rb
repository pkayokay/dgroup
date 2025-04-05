class Week < ApplicationRecord
  store :memory_verse_data, accessors: [:reference, :comment, :completed], prefix: "memory_verse", coder: JSON
  belongs_to :plan

  def completed?
    chapters_data.all? { |chapter| chapter["completed"] } && memory_verse_completed
  end
end
