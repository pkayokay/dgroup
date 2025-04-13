class PlansController < ApplicationController
  def show
    @plan = Current.user.plan || Plan.new

    if @plan.persisted?
      if params[:tab] == "all_weeks"
        @weeks = @plan.weeks        
        @current_week_position = find_plan_for_current_week&.position
      elsif params[:tab].blank?
        @weeks = [find_plan_for_current_week]
      end
    end
  end

  def find_plan_for_current_week
    eastern_time = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)").now
    @plan.weeks.find_by(start_date: eastern_time.beginning_of_week..eastern_time.end_of_week)
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to request.referrer, notice: "Plan updated"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def create
    Plan.transaction do
      @plan = Plan.new(plan_params)
      @plan.user = Current.user

      @plan.save!
      @plan.generate_weeks!

      redirect_to root_path
    rescue => e
      render :show, status: :unprocessable_entity, alert: e.message
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    
    if @plan.destroy
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def plan_params
    params.expect(plan: [:plan_type, :start_date])
  end
end
