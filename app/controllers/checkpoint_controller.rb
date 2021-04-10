class CheckpointController < ApplicationController
  before_action :set_habit, only: %i[create update]

  def new
  end

  def create
    @checkpoint = @habit.checkpoint.create(checkpoint_params)
    if @checkpoint.valid?
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

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def checkpoint_params
    params.require(:checkpoint).permit(:title, :description, :due_date, :status, :day_id)
  end
end
