class ConversationController < ApplicationController
#before_filter :confirm_logged_in
	
	#GET
	def index
		

	end
	
	#GET
	def new
	  render "new"
	end
	
	def create
	end
	
	#GET
	def show
	  render "show"
	end	
	
	
	#GET
	def edit
	  render"edit"
	end
	
	def update
	end
	
	def destroy
	end
	
end
