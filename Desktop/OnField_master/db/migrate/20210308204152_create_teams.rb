class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :sports
      t.integer :member
      t.string :play_area
      t.string :attribute
      t.string :performance
      t.text :team_contents
      t.integer :men
      t.integer :women
      t.string :team_image

      t.timestamps
    end
  end
end
