class AddSoloUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :solo_user, foreign_key: true
  end
end
