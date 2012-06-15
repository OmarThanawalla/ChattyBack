class Follow < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user_id, :follow_id
	
end
