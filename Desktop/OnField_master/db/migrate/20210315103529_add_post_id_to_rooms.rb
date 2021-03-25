class AddPostIdToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :post, foreign_key: true
  end
end
