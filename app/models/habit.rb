class Habit < ApplicationRecord
  after_create :add_days
  after_update :add_days, :clean_unused_days
  belongs_to :user
  has_many :days, dependent: :delete_all
  has_many :checkpoints, dependent: :delete_all
  validates :name, :description, :start_date, :end_date, presence: true

  def self.expired_within_last_five_days
    where(end_date: (Date.today - 4.days)..Date.today)
  end

  def days_order_by_date
    days.order('date ASC')
  end

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

  def toggle_status
    self.status = !status
  end

  def self.last_day
    where(end_date: Date.today, status: false)
  end

  def able_to_be_checked?
    end_date == Date.today
  end

  def clean_unused_days
    day = self.end_date + 1.day
    loop do
      break if saved_change_to_end_date.nil?
      break if day > saved_change_to_end_date.first
      self.days.find_by(date: day).destroy if self.days.where(date: day).exists?
      day += 1.day
    end
  end

  private

  def add_days
    day = start_date
    loop do
      break if saved_change_to_end_date.nil?
      self.days.where(date: day).exists? ? day += 1.day : (self.days.create(status: false, date: day) &&  day += 1.day)
      break if day > end_date
    end
  end
end
