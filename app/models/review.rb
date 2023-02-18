class Review < ApplicationRecord
<<<<<<< HEAD
    belongs_to :exchange 
    has_one :user_review 
    has_one :user, through: :user_review
=======
  belongs_to :exchange
  has_one :user_review
  has_one :user, through: :user_review
>>>>>>> 3e2da3ab0799b24ad52ce119beb9de3ad1cb7644
end
