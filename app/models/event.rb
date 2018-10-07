class Event < ApplicationRecord
  STATUSES = {
    pending: 'Pending',
    accepted: 'Accepted',
    rejected: 'Rejected'
  }.freeze

  belongs_to :user
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users

  validates :title, :start_datetime, :end_datetime, presence: true

  after_update :reset_status

  def send_notification_emails(user_ids = nil)
    self.users.where.not(id: user_ids).each do |u|
      UserMailer.event_added(self.id, u.id).deliver_now
    end
  end

  def update_notification_emails(user_ids = nil)
    self.users.where(id: user_ids).each do |u|
      UserMailer.event_modified(self.id, u.id).deliver_now
    end
  end

  private

  def reset_status
    self.event_users.update_all(status: STATUSES[:pending])
  end
end
