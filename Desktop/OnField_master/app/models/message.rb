class Message < ApplicationRecord
    validates :content, presence: true
    # createの後にコミットする { MessageBroadcastJobのperformを遅延実行 引数はself }
    after_create_commit { MessageBroadcastJob.perform_later self }
    after_create_commit { create_notification_message! }

    belongs_to :user
    belongs_to :solo_user
    belongs_to :room
    has_many :notifications, dependent: :destroy

            private

            def create_notification_message!
                room
                notification = current_solo.active_notifications.new(
                room_id: @room.id,
                visited_id: partnar,
                action: 'message')
                if notification.visitor_id == notification.visited_id
                  notification.checked = true
                end
                notification.save if notification.valid?
            end

            def current_solo
              SoloUser.find(self.solo_user_id)
            end

            def partnar
              room
                if @room.solo_user_id == current_solo.id
                    @room.partnar_id
                else
                    @room.solo_user_id
                end
            end

            def room
                @room = Room.find(self.room_id)
            end


end