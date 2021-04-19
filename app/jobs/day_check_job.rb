class DayCheckJob < ApplicationJob
  queue_as :default

  def perform(day_habit)
    DayCheckMailer.with(day_habit: day_habit).day_check_email.deliver_now
  end
end
