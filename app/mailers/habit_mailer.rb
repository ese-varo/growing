class HabitMailer < ApplicationMailer

  def habit_last_day
    @habit = params[:habit]
    @user = @habit.user
    @url  = habit_url(@habit)
    mail(to: @user.email, subject: 'Last day of your habit')
  end
end
