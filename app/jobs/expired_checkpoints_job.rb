class ExpiredCheckpointsJob < ApplicationJob
  queue_as :default

  def perform(user)
    CheckpointMailer.with(user: user).checkpoint_expired.deliver_later
  end
end
