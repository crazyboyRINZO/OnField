class Post < ApplicationRecord

  has_many :post_takers, dependent: :destroy
  has_many :takers, through: :post_takers, dependent: :destroy

    belongs_to :solo_user

    belongs_to :user, optional: true
    has_many :comments
    has_many :rooms 
    validates :title, presence: true


    mount_uploader :game_image, GameImageUploader

      #確認画面に飛ばすため
    validates_acceptance_of :confirming
    after_validation :check_confirming

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end
end
