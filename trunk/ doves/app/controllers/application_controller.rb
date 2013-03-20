class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :loggedin?
  
  def loggedin?
	!!session[:user]
  end
  
end
