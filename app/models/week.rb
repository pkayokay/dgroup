class Week < ApplicationRecord
  store :memory_verse_data, accessors: [:reference, :comment, :completed], prefix: "memory_verse", coder: JSON
  belongs_to :plan
end
