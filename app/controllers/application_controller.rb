class ApplicationController < ActionController::Base
  protect_from_forgery

  
  #protected #so it cant be called as an action
	#def confirm_logged_in
		#so if a session[:user_id] simply exists, then you are considered logged in?
	#	if session[:user_id]
	#		return true
	#	else
	#		flash[:notice] = "Please log in"
	#		redirect_to(:controller => "login", :action => 'login')
	#		return false
	#	end
	#end
	
	#rescue_from CanCan::AccessDenied do |exception|
    #	redirect_to :controller => "login", :action => "logout"
  	#end
	
	protected
	def current_ability
  		@current_ability ||= Ability.new(@user)
	end
	
	
	
	protected
	def proofIdent
		#i have to ask your username and password then check you in the database and ask if the id 
		# that is assigned to you is the same in the
		# url you are trying to access
		if session[:user_id].to_i == params[:id].to_i #fix this
			return true
		else
			return false	
		end	
	end
	
	protected
	def check_logged_in
		authenticate_or_request_with_http_basic do |email, password|
            User.find_by_email(email) && User.find_by_email(email).hashed_password == password
        end
	end
	
  
end
