class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected #so it cant be called as an action
	def confirm_logged_in
		if session[:user_id]
			return true
		else
			flash[:notice] = "Please log in"
			redirect_to(:controller => "login", :action => 'login')
			return false
		end
	end
  
end
