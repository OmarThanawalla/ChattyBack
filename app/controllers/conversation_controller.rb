class ConversationController < ApplicationController
	def index
	  #get a list of the 20 most recent conversations for the user
 	  myConvo = UserConversationMmTable.where({:user_id => 1}).order("updated_at DESC").limit(20)
 	  
 	  #this array will hold the most recent message for each conversation
 	  mostRecentMessageForEachConversation = []
 	  
 	  #iterate through the 20 most recent conversations
 	  myConvo.each do |conversation|
 	  
		  #find the most recent message for each conversation
		  #remember this can't be an array
		  myMessage = Message.where(:conversation_id => conversation.conversation_id).order("updated_at DESC").limit(1)
		  
		  #append the most recent message
		  mostRecentMessageForEachConversation << myMessage
	  end
	  
	  @allConvo = mostRecentMessageForEachConversation
	  
	  #convert the array into json(xml)
	  render :xml => @allConvo

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
