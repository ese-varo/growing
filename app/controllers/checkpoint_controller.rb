class CheckpointController < ApplicationController
  before_action :set_day, only: %i[create update]

  def new
  end

  def create
    @checkpoint = @day.build_checkpoint(checkpoint_params)
    if @checkpoint.save
      flash[:success] = "Checkpoint created"
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = "Checkpoint not created"
      respond_to do |format|
        format.html
      end
    end
  end

  private

  def set_day
    @day = Day.find(params[:day_id])
  end

  def checkpoint_params
    params.require(:checkpoint).permit(:title, :description, :due_date, :status, :habit_id)
  end
end
