class ApplicationController < ActionController::Base
  protect_from_forgery

  protected #so it cant be called as an action
	def confirm_logged_in
		#here is where I have to ask for username and password. authenticate everywhere
		emailDowncase = params[:email].downcase
		myUser = User.find_by_email(emailDowncase)
		if myUser && myUser.hashed_password == params[:password]
			return true
		else
			render :file => "public/401.html", :status => :unauthorized
			return false
		end
	end

	protected
	def current_ability
  		@current_ability ||= Ability.new(@user)
	end

	protected
	def proofIdent
		#is who you are and the params[:id] you are trying to access one and the same?
		myUser = User.find_by_email(params[:email])
		if myUser && myUser.hashed_password == params[:password]
			if myUser.id.to_i == params[:id].to_i
				return true
			end
		end
		return false
	end
	
	protected
	def whoAreYou
		emailLowered = params[:email]
		emailLowered = emailLowered.downcase
		myUser = User.find_by_email(emailLowered)
		if myUser && myUser.hashed_password == params[:password]
			return myUser.id
		end
	end

end
