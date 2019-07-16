require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "Example User", email: "user@example.com")
  end

  test "shuold be valid" do
  	assert @user.valid?
  end

  test "name should be preset" do
  	@user.name = "     "
	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "    "
  	assert_not @user.valid?
  end

  test "name should be not too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email shuold not be too long" do
  	@user.email = "a"*244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[user@eample,com user@.com 1231@a2@com]
  	invalid_addresses.each do |invalid_address|
  		@user.email = invalid_address
  		assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  	end
  end

  test "email validation should accept valid addresses" do
  	valid_addresses = %w[user@eample.com user@abcd.com UsER@yahoo.org]
  	valid_addresses.each do |valid_address|
  		@user.email = valid_address
  		assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "email addresses should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.email = @user.email.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "email addresses shuold be saved as lowecase" do
  	email = "UseR@Example.Com"
  	@user.email = email
  	@user.save
  	assert_equal email.downcase, @user.reload.email

  end

end
