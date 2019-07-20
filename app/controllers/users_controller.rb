class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :transfer_money, only: [:payment]
  
  def index
  	users = User.paginate(page: params[:page])
  	render json: users
  end

  def new
  	user = User.new
  end

  def show
  	user = get_user(params[:id])
  	render json: user
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		# saved user to db is successful
  		render json: user
  	else
  		# render 'new' which will give users the error messages of why saving failed.
  		render json: user.errors.full_messages
  	end
  end

  def edit
  	user = get_user(params[:id])
  end

  def update
  	user = get_user(params[:id])
  	if user.update_attributes(user_params)
  		render json: @user
  	else
  		render json: user.errors.full_messages
  	end
  end

  def balance
    user = get_user(params[:id])
    if user
      if !user.account.nil?
        render json: user.account.balance
      else
        render json: {"error": "No account exists for user"}
      end 
    else
      render json: {"error": "No user exists"}
    end
  end

  def feed
    
  end


  def payment
    payment_data = payment_params
    user = get_user(params[:id])
    friend = get_user(payment_data[:friend_id])
    amount = payment_data[:amount].to_i
    message = payment_data[:message]

    if is_valid_amount?(amount)  
      if user.friendships.where(friend_id: friend.id)
        payment = user.payments.build(friend_id: friend.id, amount: amount, message: message)

        ActiveRecord::Base.transaction do
          user_new_balance = user.account.balance - amount
          friend_new_balance = friend.account.balance + amount
          
          friend.account.update_attributes(balance: friend_new_balance)
          user.account.update_attributes(balance:  user_new_balance)
          payment.save

          render json: {"message": "#{user.name} transferred #{amount} to #{friend.name} 
                                  on #{payment.created_at}" }
        end
      else
        render json: {"error": "#{friend.name} needs to be added as friend"}
      end
    else
      render json: {"error": "Amount must be greater than 0"}
    end
  end

  private

  def get_user(id)
    User.find_by(id: id)
  end

  def user_params
  	params.require(:user).permit(:name, :email)
  end

  def payment_params
    params.require(:payment_data).permit(:id, :friend_id, :amount, :message)
  end

  def is_valid_amount?(amount)
    amount > 0 && amount <= 1000
  end

  def has_enough_balance?(user_balance, amount)
    user_balance - amount > 0
  end

  def transfer_money
    payment_data = payment_params
    user = get_user(params[:id])
    amount = payment_data[:amount].to_i
    user_balance =  user.account.balance
    if is_valid_amount?(amount) && !has_enough_balance?(user_balance, amount)
      transfer_service = MoneyTransferService.new("bank", user.account)
      transfer_service.transfer(amount - user_balance + 1)
    else
      # continue as either the amount is invalid or user has enough balance
    end
  end

end

