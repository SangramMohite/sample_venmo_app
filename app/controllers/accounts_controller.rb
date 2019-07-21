class AccountsController < ApplicationController

	def index
		user = get_user		
		if user
			account = Account.find_by(user_id: user.id)
			if account
				render json: account
			else
				render json: {"error": "No account exists for user #{user.name}"}
			end
		else
			render json: {"error": "user does not exist"}
		end		 
	end

	def show		
	end

	def create
		user = get_user(params[:user_id])
		if user
			if !Account.find_by(user_id: user.id)			
				account = user.build_account(name: params[:name], balance:  params[:balance]) 
				if account.save
				# saved account to db is successful
	  				render json: account
	  			else
			  		# render 'new' which will give users the error messages of why saving failed.
			  		render json: account.errors.full_messages
			  	end
			  else
			  	# redirect user to settings page or delete account page with their account loaded.
			  		render json: {"error": "Account for #{user.name} already exists. Only one account per user."}
			  	end
		else
			render json: {"error": "User does not exist"}
		end		
	end

  private

  def user_params
  	params.require(:user_id)
  end

  def account_params
  	params.require(:account).permit(:user_id, :name, :balance)
  end

  def get_user(user_id)
  	User.find_by(id: user_id)
  end

end
