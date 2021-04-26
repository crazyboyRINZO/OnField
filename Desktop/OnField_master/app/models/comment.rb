class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :solo_user
  belongs_to :post, optional: true
end
