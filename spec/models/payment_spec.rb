require 'rails_helper'

RSpec.describe Payment, type: :model do

	subject {
		user_1 = User.create(name: "user one", email: "one@example.com")
		user_2 = User.create(name: "user two", email: "two@example.com")
		Payment.new(user_id: user_1.id, friend_id: user_2.id, amount: 10, message: "Lunch")}

	describe 'validation tests' do

		it 'is valid with valid attributes' do
			expect(subject).to be_valid
		end

		it 'is invalid if amount is less than 1' do
			subject.amount = 0
			expect(subject).to be_invalid
		end

		it 'is invalid if amount is grater than 1000' do
			subject.amount = 1001
			expect(subject).to be_invalid
		end

		it 'is invalid if friend does not exist' do
			subject.friend_id = nil
			expect(subject).to be_invalid
		end

		it 'is invalid if user does not exist' do
			subject.user_id = nil
			expect(subject).to be_invalid
		end

		# it 'is invalid if user sends payment to himself' do
		# 	subject.friend_id = subject.user_id
		# 	expect(subject).to be_invalid
		# end


	end
  
end
