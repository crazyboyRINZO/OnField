class CreateSoloUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :solo_users do |t|
      t.string :name, null: false
      t.string :sex, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :age, null: false
      t.text :contents
      t.string :sports, null: false
      t.string :school
      t.string :position
      t.integer :experience

      t.timestamps
    end
  end
end
