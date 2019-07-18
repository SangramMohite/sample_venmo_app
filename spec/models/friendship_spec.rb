require 'rails_helper'

RSpec.describe Friendship, type: :model do
  
  subject {
  	user_1 = User.create(name: "David Cross", email: "david@example.com")
  	user_2 = User.create(name: "Tedross Black", email: "tab@example.com")
  	Friendship.new(user_id: user_1.id, friend_id: user_2.id)}

  context 'validation tests' do

  	it 'valid if all attributes exist' do
  		expect(subject).to be_valid
  	end

  	# it 'is not valid if user tries to befriend himself' do
  	# 	friendship = Friendship.new(user_id: user_1.id, friend_id: user_1.id)
  	# 	expect(friendship).to be_invalid
  	# end
  end

end
