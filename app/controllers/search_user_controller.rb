class SearchUserController < ApplicationController
before_filter :confirm_logged_in

	#return a list of users that match part or all of the query
	def index
		query=  params[:searchQuery]
		#searchUsers is available in User Model 
		results = User.searchUsers(query)
		render :json => results
	end



end
