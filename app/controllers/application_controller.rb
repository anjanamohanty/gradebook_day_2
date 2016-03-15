class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    redirect_to login_path, notice: "You must log in to access this page" unless session[:user_id]
  end

  def logged_in_as_teacher?
    redirect_to login_path, notice: "You do not have permission to access that page." unless session[:user_type] == "Teacher"
  end

  def logged_in_as_student?
    redirect_to login_path, notice: "You do not have permission to access that page." unless session[:user_type] == "Student"
  end

  def logged_in_as_parent?
    redirect_to login_path, notice: "You do not have permission to access that page." unless session[:user_type] == "Parent"
  end

end
