class UserExchange < ApplicationRecord
  belongs_to :user
  belongs_to :exchange
end
