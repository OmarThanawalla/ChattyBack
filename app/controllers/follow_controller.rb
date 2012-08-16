class FollowController < ApplicationController
before_filter :confirm_logged_in

		#user sends a request to follow someone
	def index
		userID = whoAreYou()
		#targetFollow contains the userID for the person 
	  	targetUser = params[:targetFollow]
	  	
	  	#make a request to follow someone by creating a record in the Followers table and setting confirmed to 0
	  	#but first make sure a record doesn't exist (you aren't make multiple request)
	  	if Followers.where({:user_id => targetUser, :follower_id => userID}).length == 0 #a record doesnt exist yet
	  		myRequest = Followers.new({:user_id => targetUser, :follower_id => userID})
	  		myRequest.save
	  		@confirm = ["Request Sent"]
	  		render :json => @confirm
	  	else #record already exists, could be pending or could be confirmed
	  		@confirm = ["Your request is pending, please dont try again"]
	  		render :json => @confirm
	  	end
	  	

	end
	
	def new
	  render "new"
	end
	
	def edit
	  render"edit"
	end
	
	def show
	  render "show"
	end
end
