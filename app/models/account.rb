class Account < ApplicationRecord
  belongs_to :user, index: {unique: true}
  
  validates :name, presence: true, length: {minimum: 3}
  validates :user_id, presence: true
  
  validates :balance, presence: true, numericality: {greater_than: -1}

end
