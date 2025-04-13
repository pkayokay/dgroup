class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  prevent_authenticated_access
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_registration_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    if params[:user][:church_name].strip != ENV["SECRET_CODE"]
      redirect_to new_registration_url, alert: "Invalid secret code."
      return
    end
    @user = User.new(params.expect(user: [:email_address, :password, :password_confirmation]))
    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Signed up!"
    else
      render :new, status: :unprocessable_entity
    end
  end
end
