class ChangeInviteCodeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :exchanges, :invite_code, :string
  end
end
