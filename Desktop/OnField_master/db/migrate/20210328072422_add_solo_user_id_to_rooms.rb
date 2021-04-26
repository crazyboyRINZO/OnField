class AddSoloUserIdToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :solo_user, foreign_key: true
  end
end
