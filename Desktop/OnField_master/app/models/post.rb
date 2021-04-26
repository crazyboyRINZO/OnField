class Post < ApplicationRecord
  validates :title, presence: true

  has_many :post_takers, dependent: :destroy
  has_many :takers, through: :post_takers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :solo_user, optional: true
  belongs_to :user, optional: true

  mount_uploader :game_image, GameImageUploader

      #確認画面に飛ばすため
  validates_acceptance_of :confirming
  after_validation :check_confirming

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

  # ---------------申込通知---------------

  def create_notification_post_taker!(current_solo, visited_id)
    notification = current_solo.active_notifications.new(
    post_id: id,
    visited_id: visited_id,
    action: 'post_taker')

  notification.save if notification.valid?
  end

  # ---------------コメント通知---------------

  def create_notification_comment!(current_solo, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:solo_user_id).where(post_id: id).where.not(user_id: current_solo.id).distinct

    temp_ids.each do |temp_id|
      save_notification_comment!(current_solo, comment_id, temp_id['solo_user_id'])
    end

      save_notification_comment!(current_solo, comment_id, solo_user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_solo, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_solo.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
      # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  
end
