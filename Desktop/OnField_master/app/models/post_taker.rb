class PostTaker < ApplicationRecord
    belongs_to :taker, class_name: 'SoloUser', foreign_key: 'taker_id'
    validates_uniqueness_of :post_id, scope: :taker_id

    has_many :notifications

end
