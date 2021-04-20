class ExpiredHabitsReminderJob < ApplicationJob
  queue_as :default

  def perform
    return if get_expired_habits.empty?
    get_expired_habits.each do |habit|
      HabitReminderMailer.with(habit: habit).habit_expired_reminder.deliver_later
    end
  end

  private

  def get_expired_habits
    Habit.expired_within_last_five_days
  end
end
