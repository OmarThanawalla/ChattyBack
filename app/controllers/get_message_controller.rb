class GetMessageController < ApplicationController
before_filter :confirm_logged_in


#do work here because youll be sending your convo_id through the post anyways
		def index
			@messages = Message.where(:conversation_id => params[:conversationID]).order("updated_at ASC").limit(20)
			@myJSON = []
			@messages.each do |message|
				diction = {}
				diction[:id] = message.id
				diction[:message_content] = message.message_content
				diction[:user_id] = message.user_id
				diction[:conversation_id] = message.conversation_id
				diction[:created_at] = message.created_at
				diction[:updated_at] = message.updated_at
				#look up the user's name
					myUser = User.find(message.user_id)
					firstName = myUser.first_name
					lastName = myUser.last_name
					name = firstName + " " + lastName
				diction[:full_name] = name
				@myJSON  << diction
			end
			render :json => @myJSON
		end
		
		def new
		end
		
		#submit a message to an existing conversation
		def create #POST
			userID = whoAreYou()
			puts params[:conversationID]
			puts params[:message]
			
			myMessage = Message.new(:message_content => params[:message], :user_id => userID, :conversation_id => params[:conversationID])
			if myMessage.save
				@result = ["Message sent"]
				render :json => @result
			else
				@result = ["Message failed"]
				render :json => @result
			end
		end
		
		#/get_message/:id
		def show
		end
		
		def edit #GET
		end
		
		def update #PUT
		end
		
		def destroy
		end


end
