class ExchangeSerializer < ActiveModel::Serializer
  attributes :id, :invite_code, :address_1, :address_1_lat, :address_1_lng, :address_2, :address_2_lat, :address_2_lng, :meeting_address, :meeting_address_lat, :meeting_address_lng, :meettime, :user

  def user
    object.users
  end

end
