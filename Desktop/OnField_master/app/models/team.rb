class Team < ApplicationRecord
    validates :team_name, presence: true

    mount_uploader :team_image, TeamImageUploader

      #確認画面に飛ばすため
    validates_acceptance_of :confirming
    after_validation :check_confirming

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : ''
  end
end
