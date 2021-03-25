class AddUserImageToSoloUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :solo_users, :user_image, :string
  end
end
