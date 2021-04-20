class HabitTrackingMailer < ApplicationMailer
  def reminder
    @habit = params[:habit]
    mail(to: @habit.user.email, subject: "Don't forget to track your habit")
  end
end
