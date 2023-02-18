class Review < ApplicationRecord
  belongs_to :exchange
  has_one :user_review
  has_one :user, through: :user_review
end
