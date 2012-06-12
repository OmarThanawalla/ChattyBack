class FollowerController < ApplicationController
#before_filter :confirm_logged_in
before_filter :check_logged_in
	def index
	  render "index"
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
