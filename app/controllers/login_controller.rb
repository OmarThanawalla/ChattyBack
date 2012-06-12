class LoginController < ApplicationController
	#before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
	before_filter :check_logged_in
	
	#this doesnt really do anything
	def index
		@test = "If you can see this you can get into the index page, then you have cookies that rmr you are logged in"
		render :json => @test
		#render "menu"
	end

	#informs you who you are logged in as
	def menu
		@test = "if you can see this then you successfully called the menu action"
		render :json => @test
		#render "menu"
	end

	#this is where you see the login boxes
	def login #i guess with an iPhone app you never really have to log in because your app 
			  #maintains state and logins in at  every call
		@user = "if you can see this you called the login action"
		render :json => @user
		#render "login"
	end

	def attempt_login
		#authorized_user = User.authenticate(params[:email], params[:password])
		#@value = authorized_user
		
		#if http_basic_authenticate_with :name => "DWade@yahoo.com", :password => "secretPassword"
		if @value
			#mark user as logged in
			#session[:user_id] = @value.id
			#session[:username] = @value.email
			#flash[:notice] = "You are now logged in."
			
			@test = "if you can see this then you successfully logged in"
			render :json => @test
			#redirect_to(:action => "menu")
		else
			#flash[:notice] = "Invalid username/password combination"
			
			
			@user = "if you can see this you did NOT successfully log in"
			render :json => @user
			#redirect_to(:action => 'login')
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
