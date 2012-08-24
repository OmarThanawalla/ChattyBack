class MessageController < ApplicationController
before_filter :confirm_logged_in

	
	def index
	  render "index"
	end
	
	def new
	  render "new"
	end
	
	#CREATES MESSAGE AND CONVERSATION
	def create
	userID = whoAreYou()
	
	#make sure message is valid
	if params[:message] != "" && params[:message].length >= 1
		
		
		#create a conversation record
		myConvo = Conversation.create
		
		#create a linking record in UserConversation..MM Table
		myHookup = UserConversationMmTable.create(:conversation_id => myConvo.id, :user_id => userID)
		
		#create the message and link it to the convo record and user record
		myMessage = Message.create(:user_id => userID, :conversation_id => myConvo.id, :message_content => params[:message])
		
		#add any users in the message as part of the conversation
		messageList = params[:message].split()
		
		messageList.each do |word|
		
			if word[0] == "@"
				wordLowered = word.downcase
				myUser = User.where(:userName => wordLowered)
				#if its a real user then make the entry
				if myUser != nil && myUser.length != 0
					puts myUser[0].id
					#model validations and a postgresql index will make sure user cannot be in the same convo twice
					UserConversationMmTable.create(:user_id => myUser[0].id, :conversation_id => myConvo.id)
				end
			end
		end
		
		#Last Step: Apple Push notification to everyone with @<username> in the content of the message
		
		@confirmation = ["Message Sent"] #i lost one hour on this stupid error, not putting message sent in brackets lol.
		render :json => @confirmation
		#redirect_to => (:action => "index")
	end
	end
	
	def edit
	  render"edit"
	end
	
	def show
	  render "show"
	end
	
end
