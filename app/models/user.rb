class User < ActiveRecord::Base
	has_many :messages
	has_many :conversations, :through => :user_conversation_mm_tables
	
	has_many :followers
	has_many :follows
	
	has_many :followers, :foreign_key => "follower_id"
	has_many :follows, :foreign_key => "follow_id"
	
	validates :password, :length => { :in => 6..20 }
	validates :Bio, :length => { :maximum => 160 }
end
