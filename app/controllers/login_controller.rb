class LoginController < ApplicationController
	before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	
	#if username and password are found authenticate the user by returning true. else return false
	def index
		render "menu"
	end

	#def menu
	#	render "menu"
	#end

	def login
		render "login"
	end

	def attempt_login
		authorized_user = User.authenticate(params[:email], params[:password])
		@value = authorized_user
		if @value
			#mark user as logged in
			session[:user_id] = @value.id
			session[:username] = @value.email
			flash[:notice] = "You are now logged in."
			redirect_to(:action => "menu")
		else
			flash[:notice] = "Invalid username/password combination"
			redirect_to(:action => 'login')
		end
	end

	def logout
		#mark the user as logged out
		session[:user_id] = nil
		session[:username] = nil
		flash[:notice] = "You have been logged out"
		redirect_to(:action => "login")
	end

	
end
