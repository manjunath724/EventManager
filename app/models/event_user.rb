class EventUser < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :status, presence: true

  # validates_uniqueness_of :user, scope: [:start_datetime, :end_datetime] # , conditions: -> { where.not() }
end
