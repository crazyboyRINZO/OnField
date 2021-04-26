class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :accepted, presence: {message: 'にチェックを入れてください。'}

  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :solo_user, dependent: :destroy
  has_many :comments, dependent: :destroy

end
