class ExpiredCheckpointsJob < ApplicationJob
  queue_as :default

  def perform
    return if get_expired_checkpoints.empty?
    get_expired_checkpoints.each do |checkpoint|
      CheckpointMailer.with(checkpoint: checkpoint).checkpoint_expired.deliver_later!
    end
  end

  private

  def get_expired_checkpoints
    Checkpoint.expired
  end
end
