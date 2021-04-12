class Habit < ApplicationRecord
  after_create :add_days
  after_update :add_days, :clean_unused_days
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

  def clean_unused_days
    day = self.end_date
    loop do
      self.days.where(date: day).exists? ? self.days.find_by(date: day).destroy : day += 1.day 
      break if  day >= saved_change_to_end_date.first
    end
  end

  private

  def add_days
    day = start_date
    loop do
      self.days.where(date: day).exists? ? day += 1.day : (self.days.create(status: false, date: day) &&  day += 1.day)
      break if day >= end_date
    end
  end
end
