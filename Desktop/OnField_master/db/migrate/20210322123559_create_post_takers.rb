class CreatePostTakers < ActiveRecord::Migration[6.0]
  def change
    create_table :post_takers do |t|
      t.references :post, foreign_key: true
      t.references :taker, foreign_key: {to_table: :solo_users} 
      t.timestamps
    end
  end
end
