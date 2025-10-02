# frozen_string_literal: true

# :nodoc:
class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit { broadcast_notification }

  def broadcast_notification
    NotificationsChannel.broadcast_to(user, {
                                        id: id,
                                        message: message,
                                        read: read,
                                        created_at: created_at.strftime('%d %b %Y %H:%M')
                                      })
  end
end
