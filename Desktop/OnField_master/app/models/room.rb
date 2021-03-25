class Room < ApplicationRecord
    has_many :messages
    belongs_to :solo_user
    belongs_to :post, optional: true

end
