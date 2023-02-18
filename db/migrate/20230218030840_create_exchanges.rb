class CreateExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :exchanges do |t|
      t.integer :invite_code
      t.string :address_1
      t.decimal :address_1_lat
      t.decimal :address_1_lng
      t.string :address_2
      t.decimal :address_2_lat
      t.decimal :address_2_lng
      t.string :meeting_address
      t.decimal :meeting_address_lat
      t.decimal :meeting_address_lng
      t.datetime :meettime

      t.timestamps
    end
  end
end
