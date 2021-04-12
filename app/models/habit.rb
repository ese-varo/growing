class Habit < ApplicationRecord
  after_create :add_days
  belongs_to :user
  has_many :days, dependent: :delete_all
  has_many :checkpoints, dependent: :delete_all
  validates :name, :description, :start_date, :end_date, presence: true

  def start_date_format
    self.start_date.to_s(:long) 
  end
  
  def end_date_format
    self.end_date.to_s(:long) 
  end

  def has_date(date)
    (start_date..end_date).include?(date)
  end

  def current_day
    day = days.find_by(date: Date.today)
    day ? day : days.first
  end

  private

  def add_days
    day = start_date
    while day <= end_date
      self.days.create(status: false, date: day)
      day += 1.day
    end
  end
end
