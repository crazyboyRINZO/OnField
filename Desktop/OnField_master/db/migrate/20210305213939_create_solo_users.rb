class CreateSoloUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :solo_users do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.text :contents
      t.boolean :sports, null: false
      t.boolean :category, null: false
      t.string :place
      t.string :level
      t.timestamps
    end
  end
end
