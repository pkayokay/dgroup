class Plan < ApplicationRecord
  has_many :weeks, -> { order(position: :asc) }, dependent: :destroy
  belongs_to :user

  after_commit :resync_week_dates, on: :update

  def self.complete_weeks(up_to_week)
    weeks = Week.where("weeks.position <= ?", up_to_week)
    weeks.each do |week|
      week.chapters_data.each do |data|
        data["completed"] = true
      end
      week.memory_verse_data["completed"] = true
      week.save
    end
  end

  def resync_week_dates
    return unless start_date_previously_changed?

    weeks.each_with_index do |week|
      start_date, end_date = Plan.fetch_end_and_start_dates(week.position, self.start_date)
      week.update(
        start_date: start_date,
        end_date: end_date
      )
    end
  end

  enum :plan_type, {
    old_and_new_testament_reading_plan: 0,
    new_testament_reading_plan: 1,
  }

  validates :start_date, presence: true

  def self.fetch_end_and_start_dates(position, start_date)
    start_date = start_date + (position - 1).weeks
    end_date = start_date + 5.days
    [start_date, end_date]
  end

  def generate_weeks!
    case plan_type
    when "old_and_new_testament_reading_plan"
      file_path = "public/old_and_new_testament_reading_plan.json"
    when "new_testament_reading_plan"
      file_path = "public/new_testament_reading_plan.json"
    end

    JSON.parse(File.read(file_path)).each do |week|
      start_date, end_date = Plan.fetch_end_and_start_dates(week["week"], self.start_date)
      Week.create!(
        plan: self, 
        position: week["week"], 
        start_date: start_date, 
        end_date: end_date,
        chapters_data: week["chapters"].map do |chapter|
          {
            reference: chapter,
            completed: false
          }
        end,
        memory_verse_data: {
          reference: week["memory_verse"],
          completed: false,
          comment: week["memory_verse_comment"]
        },
      )
    end
  end
end
