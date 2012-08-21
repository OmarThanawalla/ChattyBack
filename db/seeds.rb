# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

 User.create(:first_name => "Omar", :last_name => "Thanawalla", :email => "omar.thanawalla@gmail.com", :hashed_password => "secretPassword", :userName => "@omar")
 User.create(:first_name => "Dwayne", :last_name => "Wade", :email => "DWade@yahoo.com", :hashed_password => "secretPassword", :userName => "@wade")
 User.create(:first_name => "Michael", :last_name => "Jackson", :email => "mj@google.com", :hashed_password => "secretPassword", :userName => "MJ")
 
 #get handles for user_id and follow_id
 
 
