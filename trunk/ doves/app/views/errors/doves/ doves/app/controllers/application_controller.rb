class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :loggedin?
  helper_method :isadmin?
  helper_method :isreviewer?
  
  def loggedin?
	!!session[:user]
  end
  
  def isadmin?
	return false if !loggedin?
	session[:user].level == "admin"
  end
  
  def isreviewer?
  return false if !loggedin?
  session[:user].level == "reviewer"
  end
  
  def ensure_admin
	redirect_to root_path, notice: "You are not authorized for that action." and return if !isadmin?
  end
  
  def ensure_logged_in
	redirect_to login_users_path, notice: "You must log in to do that." and return if !loggedin?
  end
  
  def ensure_reviewer_or_admin
	redirect_to root_path, notice: "You are not authorized for that action." and return if !isreviewer? and !isadmin?
  end
  
    
  def ensure_admin_or_self
	redirect_to login_users_path, notice: "You must be logged in to perform that action." and return if !loggedin?
	redirect_to root_path, notice: "You are not authorized for that action." and return if ((!isadmin?) and (params[:id].to_i != session[:user].id.to_i))
  end
end
