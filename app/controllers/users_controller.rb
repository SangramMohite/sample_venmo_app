class UsersController < ApplicationController
  
  def index
  	@users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		# saved user to db is successful
  		render json: @user
  	else
  		# render 'new' which will give users the error messages of why saving failed.
  		render json: @user.errors.full_messages
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		render json: @user
  	else
  		render json: @user.errors.full_messages
  	end
  end


  private

  def user_params
  	params.require(:user).permit(:name, :email)
  end

end
