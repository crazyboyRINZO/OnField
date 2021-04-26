class SoloUser < ApplicationRecord
  validates :name, presence: true

  has_many :post_takers, foreign_key: "taker_id", dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  belongs_to :user

  mount_uploader :user_image, UserImageUploader

  #確認画面に飛ばすため
  validates_acceptance_of :confirming
  after_validation :check_confirming

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # 相手からの通知
  
  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

end
