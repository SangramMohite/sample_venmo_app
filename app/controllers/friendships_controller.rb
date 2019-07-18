class FriendshipsController < ApplicationController

	def create
		user = User.find_by(id: friendship_params[:user_id])
		friend = User.find_by(id: friendship_params[:friend_id])
		if user && friend
			# if !user.friendships.find(friend.id)			
				friendship = user.friendships.build(friend_id:  params[:friend_id]) 
			if friendship.save
			# saved account to db is successful
  				render json: friendship
  			else
		  		# render 'new' which will give users the error messages of why saving failed.
		  		render json: friendship.errors.full_messages
		  	end
			  # else
			  # 	# redirect user to settings page or delete account page with their account loaded.
			  # 		render json: {"error": "Friendship for already exists."}
			  # 	end
		else
			render json: {"error": "User does not exist"}
		end		
	end

	def destroy
		user = User.find_by(id: friendship_params[:user_id])
		friendship = user.friendship.find(params[:id])
		friendship.destroy
	end


	private

	  def friendship_params
	  	params.require(:friendship).permit(:user_id, :friend_id)
	  end
end
