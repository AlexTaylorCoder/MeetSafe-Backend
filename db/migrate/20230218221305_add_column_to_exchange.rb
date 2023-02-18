class AddColumnToExchange < ActiveRecord::Migration[7.0]
  def change
    add_column :exchanges, :details, :string
  end
end
