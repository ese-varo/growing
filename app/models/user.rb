class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :phone, presence: true
  validates :phone, length: { in: 12..16 }
  has_many :habits, dependent: :destroy
end
