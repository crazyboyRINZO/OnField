class AddSoloUserIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :solo_user, foreign_key: true
  end
end
