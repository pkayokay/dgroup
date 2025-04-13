class WeeksController < ApplicationController
  before_action :set_week
  def update
    if chapters_update?
      chapter_data = @week.chapters_data.find { |chapter| chapter["reference"] == chapter_params[:reference] }
      chapter_data["completed"] = chapter_params[:completed]
    end

    if memory_verse_update?
      @week.memory_verse_completed = memory_verse_params[:completed]
    end

    if @week.save
      render json: { success: true, completed: @week.completed? }
    else
      redirect_to request.referrer, alert: "Failed to update, try again."
    end
  end

  private

  def memory_verse_update?
    params[:week][:reference].blank?
  end

  def chapters_update?
    params[:week][:reference].present?
  end

  def chapter_params
    params.expect(week: [:completed, :reference])
  end

  def memory_verse_params
    params.expect(week: [:completed])
  end

  def set_week
    @week = Current.user.plan.weeks.find(params[:id])
  end
end
