class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users

  # validates :name, :email, :phone, presence: true
  validates :email, presence: true

  def info
    "#{name} - #{email} - #{phone}"
  end
end
