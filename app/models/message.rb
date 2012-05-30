class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	
	#validates :Message_Content, :length => { :maximum => 160 }
	
end
