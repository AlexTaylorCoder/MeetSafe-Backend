class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :message
      t.integer :user_id
      t.integer :exchange_id

      t.timestamps
    end
  end
end
