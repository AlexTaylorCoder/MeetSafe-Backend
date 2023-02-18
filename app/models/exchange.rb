class Exchange < ApplicationRecord
<<<<<<< HEAD
    has_many :user_exchanges 
    has_many :users, through: :user_exchanges
    has_many :reviews 
    has_many :user_reviews, through: :reviews
=======
  has_many :user_exchanges
  has_many :users, through: :user_exchanges
  has_many :reviews
  has_many :user_reviews, through: :reviews
>>>>>>> 3e2da3ab0799b24ad52ce119beb9de3ad1cb7644
end
