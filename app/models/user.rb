class User < ApplicationRecord

	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships

	has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
	has_many :inverse_friends, through: :inverse_friendships, source: :user

	has_one :account, dependent: :destroy
	before_save {email.downcase! }

	validates :name, presence: true, length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, length: {maximum: 255},
				format: {with: VALID_EMAIL_REGEX},
				uniqueness: {case_sensitive: false}
end
