class AddSoloUserIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :solo_user_id, :integer
  end
end
