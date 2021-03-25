class Comment < ApplicationRecord
  belongs_to :solo_user
  belongs_to :post, optional: true
end
