class AccountsController < ApplicationController

	def index
		 
	end

	def show
	end

	def balance
		user_id = params[:user_id]
		user = User.find_by(id: user_id)
		if user
			account = Account.find_by(user_id: user_id)
			if account
				render json: user.account.balance
			else
				render json: {"error": "No account exists for user"}
			end	
		else
			render json: {"error": "No user exists"}
		end
		
	end
end
