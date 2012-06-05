class UserController < ApplicationController
before_filter :confirm_logged_in
	def index #show me a list of users
	  @allUser = User.all()
	  render "index"
	end
	
	#GET	/user/new
	def new #a form to create a new user
	  @user = User.new
	  render "new"
	end
	
	#this just handles the entry and then redirects to index method
	#POST
	def create #the process of creating the new user
		#params[:user] is a hash that I can get for key values :Bio, :first_name, :password etc.
		@user = User.new(params[:user])
		if @user.save == true
		#redirect to index
		 redirect_to :action => "index"
		else
		render "new"
		end
	end
	
	#GET	/user/:id		display a specific user
	def show #show me more information about a specific user
	  @myUser = User.find(params[:id])
	  render "show"
	end
	
	#returns a form with the user credentials so i can edit them
	#GET	/user/:id/edit	return an HTML form for editing a photo
	def edit #give me a form with the user in question so that i may edit his information
		@myUser = User.find(params[:id])
		render "edit"
	end
	
	#PUT(post)	/user/:id		update a specific photo
	#just updates the user and redirects to index
	def update #the process of updating that user information
		@myUser = User.find(params[:id])
		#here i can ask cancan if user has permission to update, or use load_and_authorize_resource
		if @myUser.update_attributes(params[:user])
			redirect_to :action => "index"
		else
			render "edit"
		end		
	end
	
	def prompt #the web page given to ask you are you sure you want to delete the user
		@user = User.find(params[:id])
		render "prompt"
	end
	
	#just destroy the user and redirects to index
	#DELETE	/my_conversation/:id		delete a specific conversation
	def destroy #the process of destroying the user
		@myUser = User.find(params[:id])
		if @myUser.destroy
			redirect_to :action => "index"
		else 
		render "destroy"
		end
	end
	
end
