class UserController < ApplicationController
	def index
	  @allUser = User.all()
	  render :xml => @allUser
	  
	end
	
	
	def new
	  render "new"
	end
	
	def edit
	  render"edit"
	end
	
	def show
	  @myUser = User.find(params[:id])
	  render :xml => @myUser
	end
end
