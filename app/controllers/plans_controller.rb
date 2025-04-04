class PlansController < ApplicationController
  def show
    @plan = Current.user.plan || Plan.new
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to root_path
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
