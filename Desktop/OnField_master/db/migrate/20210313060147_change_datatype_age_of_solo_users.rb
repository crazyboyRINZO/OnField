class ChangeDatatypeAgeOfSoloUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :solo_users, :age, :datetime
  end
end
