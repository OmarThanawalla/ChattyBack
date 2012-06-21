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
		  
		  
		  @myJSON=[]
		 	#store message object attributes in a a dictionary
			mostRecentMessageForEachConversation.each do |message|
				diction = {}
				diction[:conversation_id] = message.conversation_id
				#look up all participants in the conversation
					linkingUserConvoList = UserConversationMmTable.where(:conversation_id => message.conversation_id)
					#iterate this list to find the names of the users
					recipient = ""
					linkingUserConvoList.each do |record|
						myUser = User.find(record.user_id) #find the user
						firstName = myUser.first_name
						name = firstName + ". " 
						recipient << name
					end
				diction[:recipient] = recipient	
				diction[:created_at] = message.created_at
				diction[:id] = message.id
				diction[:message_content] = message.message_content
				diction[:user_id] = message.user_id
					#look up the user's name
					myUser = User.find(message.user_id)
					firstName = myUser.first_name
					lastName = myUser.last_name
					name = firstName + " " + lastName
				diction[:full_name] = name
				#append the dictionary into the array
				@myJSON << diction
			end
			
		 render :json => @myJSON
		 	
		  
		  
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
