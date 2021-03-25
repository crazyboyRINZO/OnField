class RemoveSoloUserIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :comments, :solo_user, foreign_key: true

  end
end
