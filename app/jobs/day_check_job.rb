class DayCheckJob < ApplicationJob
  queue_as :default

  def perform(*args)
    days = get_unchecked_days
    return if days.empty?
    days.each do |day|
      DayCheckMailer.with(day_habit: day).day_check_email.deliver_later!
    end
  end

  private

  def get_unchecked_days
    days = Day.where(status: false, date: Date.today)
  end
end
