class Followers < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :follower_id	
end
