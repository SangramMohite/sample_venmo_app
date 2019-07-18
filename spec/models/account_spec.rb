require 'rails_helper'

RSpec.describe Account, type: :model do
	
	# let(:user) {User.create(name: "user one", email: "user@example.com")}
	subject {
		user = User.create(name: "user one", email: "user@example.com")
		user.build_account(name: "bofa", balance: 231)}
	
	context 'validation tests' do

		it 'is valid if user, name and balance exists' do
			subject.user_id = 1
			expect(subject).to be_valid
		end

		it 'is valid if  balance is greater than 0' do
			subject.user_id = 1
			subject.balance = 120
			expect(subject).to be_valid
		end

		it 'is valid if name exists' do
			subject.user_id = 1
			subject.name = "bofa"
			expect(subject).to be_valid
		end

		it 'is invalid if name does not exist' do
			subject.user_id = 1
			subject.name = nil
			expect(subject).to be_invalid

			subject.name = ""
			expect(subject).to be_invalid

			subject.name = "      "
			expect(subject).to be_invalid			
		end

		it 'is invalid if name is shorter than 3 characters' do
			subject.user_id = 1
			subject.name = "as"
			expect(subject).to be_invalid			
		end

		it 'is invalid if name is not a alphabet' do
			subject.user_id = 1
			subject.name = "23124124"
			expect(subject).to be_invalid

			subject.name = "@{@$$@@@}"
			expect(subject).to be_invalid
		end

		it 'is invalid if user id does not exist' do
			subject.user_id = nil
			expect(subject).to be_invalid
		end

		it 'is invalid if balance is less than 0' do
			subject.user_id = 1
			subject.balance = -1
			expect(subject).to be_invalid
		end

		it 'is invalid if balance is not a number' do
			subject.user_id = nil
			subject.balance = "  "
			expect(subject).to be_invalid

			subject.balance = "asdafa"
			expect(subject).to be_invalid

			subject.balance = "@@$$"
			expect(subject).to be_invalid
		end


		describe 'Associations' do
			it 'belongs to one user' do
				association = described_class.reflect_on_association(:user)
				expect(association.macro).to eq :belongs_to
			end
		end
	end
  
end
