class SoloUser < ApplicationRecord
  validates :name, presence: true

  has_many :post_takers, foreign_key: "taker_id", dependent: :destroy
  has_many :posts
  has_many :comments
  has_many :rooms
  has_many :messages

  belongs_to :user

  mount_uploader :user_image, UserImageUploader

  #確認画面に飛ばすため
  validates_acceptance_of :confirming
  after_validation :check_confirming
  
  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end

end
