class MessageController < ApplicationController
before_filter :confirm_logged_in

	def index
	  render "index"
	end
	
	def new
	  render "new"
	end
	
	#handles the create action
	def create
	userID = whoAreYou()
	
	#make sure message is valid
	if params[:message] != "" && params[:message].length >= 1
		#create a conversation record
		myConvo = Conversation.create
		#create a linking record in UserConversation.. Table
		myHookup = UserConversationMmTable.create(:conversation_id => myConvo.id, :user_id => userID)
		#create the message and link it to the convo record and user record
		myMessage = Message.create(:user_id => userID, :conversation_id => myConvo.id, :message_content => params[:message])
		@confirmation = "Message Sent"
		render :json => @confirmation
	end
	end
	
	def edit
	  render"edit"
	end
	
	def show
	  render "show"
	end
	
end
