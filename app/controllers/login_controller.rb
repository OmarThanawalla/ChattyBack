class LoginController < ApplicationController
	before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	#before_filter is called on every action request.
	#if it returns true you may proceed on
	#if it return false it constantly redirects you to the login page until you get
	# that session[user_id] value
	
	
	#if username and password are found authenticate the user by returning true. else return false
	def index
	##############################
	#not sure if this will work
		#username = params[:username]
		#password = params[:password]
		#auth = User.authenticate(username, password)
		#if auth #if authenticate we shall get the record back
			#retrieve the inner circle list of conversations api, or maybe just return true?
			#mark this guy as logged in and he's good to go in any further requests
		#else #not authenticated
			#challenge him, send error and tell him username and/or password not correct
			
		#end
	###############################
		render "menu"
	end

	def menu
		render "menu"
	end

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
