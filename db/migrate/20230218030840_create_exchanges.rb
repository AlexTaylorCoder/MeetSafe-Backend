class CreateExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :exchanges do |t|
      t.integer :invite_code
      t.string :address_1
      t.integer :address_1_lat
      t.integer :address_1_lng
      t.string :address_2
      t.integer :address_2_lat
      t.integer :address_2_lng
      t.string :meeting_address
      t.integer :meeting_address_lat
      t.integer :meeting_address_lng
      t.datetime :meettime

      t.timestamps
    end
  end
end
