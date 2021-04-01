class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :phone, :password, presence: true
  validates :phone, length: { in: 13..16 }
  has_many :habits, dependent: :destroy
end
