class User < ApplicationRecord
    has_secure_password  #password conformation and authentication
    has_many :user_exchanges
    has_many :exchanges, through: :user_exchanges 
    has_many :user_reviews 
    has_many :reviews, through: :user_reviews

    has_one_attached :avatar 
    has_secure_password

    validates :username, uniqueness: true
    validates :email, uniqueness: true

    # Implemented when sent to production
    # validates :phone, uniqueness: true 

    validates :username, presence: true
    validates :email, presence: true
    validates :phone, presence: true
    validates :password, presence: true
    validates :avatar, presence: true



end
