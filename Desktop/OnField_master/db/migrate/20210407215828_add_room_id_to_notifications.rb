class AddRoomIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :room, foreign_key: true, optional: true
  end
end