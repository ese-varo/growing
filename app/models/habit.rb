class Habit < ApplicationRecord
  belongs_to :user
  validates :name, :description, :start_date, :end_date, presence: true
end
