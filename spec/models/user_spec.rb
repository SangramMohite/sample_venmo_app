require 'rails_helper'

RSpec.describe User, type: :model do
	subject {described_class.create(name: "user one", email: "user_test@example.com")}

	context 'validation tests' do

		it 'is valid with valid attributes' do
			expect(subject).to be_valid
		end

		it 'is not valid without a name' do
			subject.name = nil
			expect(subject).to be_invalid
		end

		it 'is not valid without an email' do
			subject.email = nil
			expect(subject).to be_invalid
		end

		it 'is not valid when name is longer than 50 characters' do
			subject.name = "a" * 55
			expect(subject).to be_invalid
		end

		it 'is not valid when email is longer than 255 characters' do
			subject.email = "a" * 244 + "@example.com"
			expect(subject).to be_invalid
		end

		it 'is valid if email address is formatted correctly' do
			valid_addresses = %w[user@examples.com USER@foo.COM A_US-ER@foo.bar
							 first.last@foo.jp alice+bob@bz.cn]
			valid_addresses.each do |valid_address|
				subject.email = valid_address
				expect(subject).to be_valid
			end
		end

		it 'is not valid if email address is not formatted correctly' do
			invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                       foo@bar_baz.com foo@bar+baz.com]
			invalid_addresses.each do |invalid_address|
				subject.email = invalid_address
				expect(subject).to be_invalid
			end
		end
	end

	context 'Association tests' do

		it 'has one account' do
			association = described_class.reflect_on_association(:account)
			expect(association.macro).to eq :has_one
		end
	end

end
