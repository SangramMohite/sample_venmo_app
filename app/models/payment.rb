class Payment < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :friend_id, presence: true  
  
  validates_numericality_of :amount, greater_than:  0, less_than_or_equal_to:  1000

  before_create :check_if_user_is_friend




	# Before actions

	def check_if_user_is_friend
		
	end 

end
