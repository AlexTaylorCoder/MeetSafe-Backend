class User < ApplicationRecord
    has_secure_password  #password conformation and authentication
    has_many :user_exchanges
    has_many :exchanges, through: :user_exchanges 
    has_many :user_reviews 
    has_many :reviews, through: :user_reviews

    has_one_attached :avatar 
    has_secure_password

end
