module PlanHelper
  def format_date(date)
    date.strftime("%B %d, %Y")
  end

  def format_date_range(start_date, end_date)
    "#{start_date.strftime("%a, %B %d")} - #{end_date.strftime("%a, %B %d")}"
  end
end
