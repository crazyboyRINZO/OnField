class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      
      t.string "title"
      t.datetime "match_time"
      t.datetime "deadline"
      t.string "area"
      t.string "place"
      t.string "level"
      t.text "game_contents"
      t.string "game_image"
      t.integer "partner_id"
      t.string "status"
      t.time "match_start"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
