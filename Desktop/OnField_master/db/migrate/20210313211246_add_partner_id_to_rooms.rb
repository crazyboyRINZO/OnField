class AddPartnerIdToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :partnar_id, :integer
  end
end
