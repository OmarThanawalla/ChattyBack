class UserController < ApplicationController
	def index
	  @allUser = User.all()
	  render "index"
	end
	
	#GET	/user/new
	def new
	  @user = User.new
	  render "new"
	end
	
	#this just handles the entry and then redirects to index method
	#POST
	def create
		#params[:user] is a hash that I can get for key values :Bio, :first_name, :password etc.
		@user = User.new(params[:user])
		if @user.save == true
		#redirect to index
		 redirect_to :action => "index"
		else
		render "new"
		end
	end
	
	#GET	/user/:id		display a specific conversation
	def show
	  @myUser = User.find(params[:id])
	  render "show"
	end
	
	#returns a form with the user credentials so i can edit them
	#GET	/user/:id/edit	return an HTML form for editing a photo
	def edit
		@myUser = User.find(params[:id])
		render "edit"
	end
	
	#PUT(post)	/user/:id		update a specific photo
	#just updates the user and redirects to index
	def update
		
		@myUser = User.find(params[:id])
		if @myUser.update_attributes(params[:user])
			redirect_to :action => "index"
		else
			render "edit"
		end		
	end
	
	#just destroy the user and redirects to index
	#DELETE
	def destroy
		
	end
	
end
