# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

 User.create(:first_name => "Omar", :last_name => "Thanawalla", :email => "omar.thanawalla@gmail.com", :hashed_password => "secretPassword", :userName => "@omar")
 User.create(:first_name => "Dwayne", :last_name => "Wade", :email => "DWade@yahoo.com", :hashed_password => "secretPassword", :userName => "@wade")
 Follow.new(:user_id => 1, :follow_id => 2).save
 Follow.new(:user_id => 2, :follow_id => 1).save
 Followers.new(:user_id => 1, :follower_id => 2, :Confirmed => true).save
 Followers.new(:user_id => 2, :follower_id => 1, :Confirmed => true).save