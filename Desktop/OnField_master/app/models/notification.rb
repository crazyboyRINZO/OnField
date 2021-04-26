class Notification < ApplicationRecord
    # 降順でデータを持ってくる
    default_scope -> { order(created_at: :desc) }

    belongs_to :post_taker, optional: true
    belongs_to :comment, optional: true
    belongs_to :message, optional: true
    belongs_to :post, optional: true

  
    belongs_to :visitor, class_name: 'SoloUser', foreign_key: 'visitor_id', optional: true
    belongs_to :visited, class_name: 'SoloUser', foreign_key: 'visited_id', optional: true
end
