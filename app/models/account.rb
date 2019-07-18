class Account < ApplicationRecord
  belongs_to :user
  
  VALID_NAME_REGEX = /\A[a-zA-Z]+\z/i

  validates :name, presence: true, length: {minimum: 3}, format: {with: VALID_NAME_REGEX}
  validates :user_id, presence: true
  
  validates :balance, presence: true, numericality: {greater_than: -1}

end
