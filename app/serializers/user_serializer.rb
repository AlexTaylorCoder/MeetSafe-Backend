class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :email, :address, :state, :zipcode, :lat, :lng

  has_many :user_exchanges
  has_many :exchanges, through: :user_exchanges 
  has_many :user_reviews 
  has_many :reviews, through: :user_reviews

  has_one_attached :avatar 
  has_secure_password
end
