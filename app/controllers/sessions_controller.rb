class SessionsController < ApplicationController

  def new

  end

  def create
    user = (params[:user_type]).constantize.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_type] = params[:user_type]

      redirect_to root_path, notice: "You have logged in!" if session[:user_type] == "Teacher"
      redirect_to student_path id: session[:user_id] if session[:user_type] == "Student"
      redirect_to parent_path id: session[:user_id] if session[:user_type] == "Parent"
    else
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to login_path, notice: "You have logged out."
  end

end
