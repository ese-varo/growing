class CheckpointMailer < ApplicationMailer

  def checkpoint_expired
    @checkpoint = params[:checkpoint]
    @habit = @checkpoint.habit
    @user = @habit.user
    @url  = habit_url(@habit)
    mail(to: @user.email, subject: 'Checkpoint expired')
  end
end
