class MyConversationController < ApplicationController
#before_filter :confirm_logged_in
  before_filter :check_logged_in
	# GET /my_conversation
	def index
	  #get a list of the 20 most recent conversations for the user
	  											#user_id has to be gotten from authentication
 	  myConvo = UserConversationMmTable.where({:user_id => 1}).order("updated_at DESC").limit(20)
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
	  @allConvo = mostRecentMessageForEachConversation
	  #convert the array into json(xml)
	  #render :xml => @allConvo
	  render "index"
	end
	
	#GET	/my_conversation/new		return an HTML form for creating a new photo
	def new
	  render "new"
	end
	
	#POST	/my_conversation	create	create a new message(and new conversation?)
	def create
	end
	
	#GET	/my_conversation/:id/edit	return an HTML form for editing a photo
	def edit
	  render"edit"
	end
	
	#GET	/my_conversation/:id		display a specific conversation
	def show
	  #display all the messages for the given conversation
	  #but does the user have access to that conversation_id (authroization?)
	  @convoID = params[:id]
	  myMessage = Message.where({:conversation_id => params[:id]})
	  @messages = myMessage
	  #render :xml => @messages
	  render "show"
	end	
	
	#PUT	/my_conversation/:id		update a specific conversation
	def update
	end
	
	#DELETE	/my_conversation/:id		delete a specific conversation
	def destroy
	end
	
end

