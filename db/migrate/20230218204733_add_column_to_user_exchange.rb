class AddColumnToUserExchange < ActiveRecord::Migration[7.0]
  def change
    add_column :user_exchanges, :present, :boolean, default: false 
  end
end
