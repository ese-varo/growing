class Habit < ApplicationRecord
  validates :name, :description, :start_date, :end_date, presence: true
end
