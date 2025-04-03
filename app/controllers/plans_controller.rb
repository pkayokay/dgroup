class PlansController < ApplicationController
  def show
    @plan = Current.user.plan || Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = Current.user
    if @plan.save
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
