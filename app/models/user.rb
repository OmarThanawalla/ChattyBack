require 'digest/sha1'
class User < ActiveRecord::Base
	rolify
	has_many :messages
	has_many :conversations, :through => :user_conversation_mm_tables
	
	has_many :followers
	has_many :follows
	
	has_many :followers, :foreign_key => "follower_id"
	has_many :follows, :foreign_key => "follow_id"
	
	#attr_accessor :password
	
	#before_save :create_hashed_password
	#after_save :clear_password
	
	validates :Bio, :length => { :maximum => 160 }
	
	validates_presence_of :email, :first_name, :last_name, :userName
	#on create means only when the record is being created, i think it suspends the check if we're trying to update
	validates_length_of :hashed_password, :within => 8..25, :on => :create
	validates_length_of :hashed_password, :within => 8..25, :on => :update
	
	#make sure email and userName are valid for each user
	validates :email, :uniqueness => { :case_sensitive => false }
	validates :userName, :uniqueness => { :case_sensitive => false }
	
	#i just grabbed this from a website, not sure if it actually works lol
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	
	#protects from illegal mass assignment
	attr_accessible :first_name, :last_name, :email, :hashed_password, :Bio, :pictureURL, :userName #, :salt	
		
		
		
	def self.make_salt(username = "")
		#username gives us unique salt and Time.now gives us random salt
		Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
	end


    def self.hash_with_salt(hash_password ="")
    	Digest::SHA1.hexdigest("Put on the #{hash_password}")
    end

	#returns record if authenticated else returns false
	def self.authenticate(email = "", incomingPassword = "")
		myUser = User.find_by_email(email)
		if myUser && myUser.hashed_password ==  incomingPassword #self.hash_with_salt(incomingPassword)
			return myUser
		else
			return false
		end
	
	end	
	
	def self.searchUsers(query,userID)
		results = nil
		queryList = query.split()
			#a first name AND last name were queried
		if queryList.length >= 2
			firstName = queryList[0]
			lastName = queryList[1]
			firstName = firstName.capitalize()
			lastName = lastName.capitalize()
			results = User.where({:first_name => firstName, :last_name => lastName})
			
			#a first OR last name was queried
		else
			name = queryList[0]
			name = name.capitalize()
			lastNameResults = User.where(:last_name => name)
			firstNameResults = User.where(:first_name => name)
			#append results in a list
			results = firstNameResults + lastNameResults
		end
		#you can't return yourself as a user because you shouldn't be able to follow yourself, that would be weird
		#check results to see if you are in the results, if so then delete user object from results
		results.each_index do |index|
			if results[index].id == userID.id #if you are in the results 
				results.delete_at(index)
			end
		end

		#clear important attributes if a list of users is found
		if results[0] != nil
				results.each do |user|
					user.email = nil
					user.hashed_password = nil
					user.last_sign_in_ip = nil
					user.reset_password_token = nil
					user.salt = nil
					user.sign_in_count = nil
				end
		end
		return results
	end
	
	#private
	#def create_hashed_password
		#if blank then dont run this code because i assume you are not trying to update the password
		#and the validates password on create protectes me from a blank password
	#	unless password.blank?
	#		self.salt = User.make_salt(email) if salt.blank?
	#		self.hashed_password = User.hash_with_salt(password,salt)
	#	end
	#end
	
	#def clear_password
	#	self.password = nil
	#end
end
