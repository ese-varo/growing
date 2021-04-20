class Checkpoint < ApplicationRecord
  belongs_to :habit
  belongs_to :day
  has_one :note, as: :noteable, dependent: :destroy

  validates :title, :description, :due_date, presence: true
  validate :due_date_within_dates_of_habit

  private

  def self.expired
    where(due_date: Date.today)
  end

  def due_date_within_dates_of_habit
    unless Habit.find(habit_id).has_date(due_date)
      errors.add(:due_date, "should be within habit start date and end date")
    end
  end
end
