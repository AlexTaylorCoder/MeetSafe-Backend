class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :address
      t.string :state
      t.integer :zipcode
      t.integer :lat
      t.integer :lng

      t.timestamps
    end
  end
end
