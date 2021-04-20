class LastDayHabitJob < ApplicationJob
  queue_as :default

  def perform
    return if get_last_day_habits.empty?
    get_last_day_habits.each do |habit|
      HabitMailer.with(habit: habit).habit_last_day.deliver_later
    end
  end

  private

  def get_last_day_habits
    Habit.last_day
  end
end
