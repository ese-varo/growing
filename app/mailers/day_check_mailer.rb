class DayCheckMailer < ApplicationMailer
  
  def day_check_email
    @day_habit = params[:day_habit]
    @habit = @day_habit.habit
    @user = @habit.user
    @email = @user.email
    mail(to: @email, subject: "Don't forget to check your habit!")
  end
end
