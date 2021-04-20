class ReminderHabitTrackingJob < ApplicationJob
  queue_as :default

  def perform
    @users = User.all

    @users.each do |user|
      user.habits.each do |habit|
        days = habit.days.where('date < ?', Date.today).last(4)
        HabitTrackingMailer.with(habit: habit).reminder.deliver_later if evaluate_days(days)
      end
    end
  end

  def evaluate_days(days)
    sum = sum_untracked_days(days)
    four_days?(sum)
  end

  def sum_untracked_days(days)
    sum = 0
    days.map { |day| sum += 1 unless day.status }
    sum
  end

  def four_days?(sum)
    sum == 4
  end
end
