class UserController < ApplicationController
before_filter :confirm_logged_in, :except => [:new, :create]
load_and_authorize_resource
skip_load_resource :only => :index

	def index #show me a list of users
	  #find out who are you
	  @user = User.find(session[:user_id])
	  @users = User.all()
	  render "index"
	end
	
	#GET	/user/new
	def new #a form to create a new user
	  render "new"
	end
	
	#this just handles the entry and then redirects to index method
	#POST
	def create #the process of creating the new user
		#params[:user] is a hash that I can get for key values :Bio, :first_name, :password etc.
		
		#params[:user][:hashed_password] = User.hash_with_salt(params[:user][:hashed_password])
		@user = User.new(params[:user])
		#any new user is a normalUser, I probably want to put this in the model?
		@user.add_role :normalUser
		if @user.save == true
			#redirect to index
			redirect_to :controller => "login", :action => "logout"
		else
			@user.hashed_password = ""			
			render "new"
		end
	end
	
	#GET	/user/:id		display a specific user
	def show #show me more information about a specific user
	 if proofIdent() == true
	  	 render "show"
	 else
	  	 redirect_to :controller => "login", :action => "index"
	  end	 
	end
	
	#returns a form with the user credentials so i can edit them
	#GET	/user/:id/edit	return an HTML form for editing a photo
	def edit #give me a form with the user in question so that i may edit his information
		if proofIdent() == true
		   @user.hashed_password = ""
	  	   render "edit"
	 	else
	  	   redirect_to :controller => "login", :action => "index"
	  	end	 
	end
	
	
	#PUT(post)	/user/:id		update a specific photo
	#just updates the user and redirects to index
	def update #the process of updating that user information
		if proofIdent() == true
			#puts "this is the value of @user.updatetheatrributesparamsuser"
			#puts @user.update_attributes(params[:user])
			#hash the password
			#if password is blank it will try to hash it again
			#params[:user][:hashed_password] = User.hash_with_salt(params[:user][:hashed_password])
			if @user.update_attributes(params[:user])
				redirect_to :action => "show"
			else
				@user.hashed_password = ""
				render "edit"
			end
		else
			redirect_to :controller => "login", :action => "index"
		end		
	end
	
	def prompt #the web page given to ask you are you sure you want to delete the user
		#@user = User.find(params[:id])
		if proofIdent() == true
			render "prompt"
		else
			redirect_to :controller => "login", :action => "index"
		end
	end
	
	#just destroy the user and redirects to index
	#DELETE	/my_conversation/:id		delete a specific conversation
	def destroy #the process of destroying the user
	  if proofIdent() == true
		#@user = User.find(params[:id])
		if @user.destroy
			redirect_to :controller => "login", :action => "logout"
		else 
		    render "destroy"
		end
	  else
	  	 redirect_to :controller => "login", :action => "index"
	  end	
	end
	
end
