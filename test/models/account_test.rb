require 'test_helper'

class AccountTest < ActiveSupport::TestCase

	def setup
		@user = users(:david)
		@account = @user.build_account(name: "Bofa", balance: 100)
	end

	test "should be valid" do
		assert @account.valid?
	end

	test "name should be present" do
		@account.name = " "
		assert_not @account.valid?
	end

	test "balance should be greater than -1" do
		@account.balance = -10
		assert_not @account.valid?
	end

	test "valid account if balance is grater than -1" do
		@account.balance = 0
		assert @account.valid?

		@account.balance = 1000
		assert @account.valid?
	end

	test "user id should be present" do
		@account.user_id = nil
		assert_not @account.valid?
	end

	test "should destroy account when user is deleted" do
		@user = User.new(name: "sample user", email: "sample@example.com")
		@user.save
		@account = @user.create_account!(name: "City Bank", balance: 100)

		assert_difference "Account.count", -1 do
			@user.destroy
		end
		
	end

  # test "the truth" do
  #   assert true
  # end
end
