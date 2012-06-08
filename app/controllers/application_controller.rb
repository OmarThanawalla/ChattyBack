class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected #so it cant be called as an action
	def confirm_logged_in
		#so if a session[:user_id] simply exists, then you are considered logged in?
		if session[:user_id]
			return true
		else
			flash[:notice] = "Please log in"
			redirect_to(:controller => "login", :action => 'login')
			return false
		end
	end
	
	#rescue_from CanCan::AccessDenied do |exception|
    #	redirect_to :controller => "login", :action => "logout"
  	#end
	
	protected
	def current_ability
  		@current_ability ||= Ability.new(@user)
	end
	
	protected
	def proofIdent
		if session[:user_id].to_i == params[:id].to_i
			return true
		else
			return false	
		end	
	end
	
	
  
end
