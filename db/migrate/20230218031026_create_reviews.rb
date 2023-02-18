class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewed_id
      t.integer :exchange_id
      t.integer :rating
      t.string :content

      t.timestamps
    end
  end
end
