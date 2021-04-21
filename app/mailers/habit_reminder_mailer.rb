class HabitReminderMailer < ApplicationMailer

  def habit_expired_reminder
    @habit = params[:habit]
    @user = @habit.user
    @url  = habit_url(@habit)
    mail(to: @user.email, subject: 'Habit expired reminder')
  end
end
