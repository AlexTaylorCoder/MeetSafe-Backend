class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password_digest, :email, :address, :state, :zipcode, :lat, :lng, :avg_rating, :avatar

  def avg_rating 
    object.reviews.average(:rating)
  end
  def avatar
    if object.avatar.attached?
      #      Rails.application.routes.url_helpers.rails_representation_url(object.image.variant(resize: "300x300").processed, only_path: true)
      Rails.application.routes.url_helpers.rails_blob_path(object.avatar, host: "local")
    end
  end
end
