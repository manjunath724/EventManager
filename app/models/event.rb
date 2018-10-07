class Event < ApplicationRecord
  has_and_belongs_to_many :users

  validates :title, :start_datetime, :end_datetime, presence: true
end
