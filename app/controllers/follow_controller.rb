class FollowController < ApplicationController
#before_filter :confirm_logged_in

		#user sends a request
	def index
		userID = whoAreYou()
	  	targetUser = params[:targetFollow]
	  	
	  	#make a request to follow someone by creating a record in the Followers table and setting confirmed to 0
	  	myRequest = Followers.new({:user_id => targetUser, :follower_id => userID})
	  	myRequest.save
	  	
	  	@confirm = ["Request Sent"]
	  	render :json => @confirm
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
