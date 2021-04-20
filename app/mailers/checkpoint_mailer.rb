class CheckpointMailer < ApplicationMailer
  default from: 'from@example.com'

  def checkpoint_expired
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email, subject: 'Checkpoint expired')
  end
end
