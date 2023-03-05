class AddColumnToUserExchange2 < ActiveRecord::Migration[7.0]
  def change
    add_column :user_exchanges, :isAccepted, :boolean
  end
end
