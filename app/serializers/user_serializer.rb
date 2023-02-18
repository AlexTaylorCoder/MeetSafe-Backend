class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :email, :address, :state, :zipcode, :lat, :lng, :avg_rating

  def avg_rating 
    object.reviews.average(:rating)
  end

end
