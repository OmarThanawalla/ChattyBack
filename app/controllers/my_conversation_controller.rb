class MyConversationController < ApplicationController
before_filter :confirm_logged_in

	#returns a list of conversations that the user is a part of
	def index
	userID = whoAreYou()
	 #get a list of the 20 most recent conversations for the user
													#user_id has to be gotten from authentication
		  myConvo = UserConversationMmTable.where({:user_id => userID}).order("updated_at DESC").limit(20)
		  #this array will hold the most recent message for each conversation
		  mostRecentMessageForEachConversation = []
		  #iterate through the 20 most recent conversations
		  myConvo.each do |conversation|
			  #find the most recent message for each conversation
			  #remember this can't be an array
			  myMessage = Message.where(:conversation_id => conversation.conversation_id).order("updated_at DESC").limit(1)
			  #append the most recent message
			  mostRecentMessageForEachConversation << myMessage[0]
		  end
		  @conversations = mostRecentMessageForEachConversation
		  render :json => @conversations
	end

	def new
	end
	
	def create
	end
	
	def show
	end
	
	def edit
	end
	
	def update
	end
	
	def destroy
	
	end
end	
