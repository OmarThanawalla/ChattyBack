class User < ActiveRecord::Base
	has_many :messages
	has_many :conversations, :through => :user_conversation_mm_tables
	
	has_many :followers
	has_many :follows
	
	has_many :followers, :foreign_key => "follower_id"
	has_many :follows, :foreign_key => "follow_id"
	
	validates :password, :length => { :in => 6..20 }
	validates :Bio, :length => { :maximum => 160 }
	
	validates_presence_of :email,  :password, :first_name, :last_name
	validates :email, :uniqueness => { :case_sensitive => false }
	
	#i just grabbed this from a website, not sure if it actually works lol
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	
end
