class Exchange < ApplicationRecord
  has_many :user_exchanges
  has_many :users, through: :user_exchanges
  has_many :reviews
  has_many :user_reviews, through: :reviews
end
