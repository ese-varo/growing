class CheckpointController < ApplicationController
  before_action :set_day, only: %i[create update]
  before_action :set_habit, only: :update
  before_action :set_checkpoint, only: :update

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
      redirect_to @habit, danger: "Checkpoint not created"
    end
  end

  def update
    @checkpoint.update(checkpoint_params)
    if @checkpoint.save
      flash[:success] = "Checkpoint updated"
      respond_to do |format|
        format.js
      end
    else
      redirect_to @habit, danger: "Checkpoint not updated"
    end
  end

  private

  def set_day
    @day = Day.find(params[:day_id])
  end

  def set_habit
    @habit = Habit.find(params[:checkpoint][:habit_id])
  end

  def set_checkpoint
    @checkpoint = Checkpoint.find(params[:id])
  end

  def checkpoint_params
    params.require(:checkpoint).permit(:title, :description, :due_date, :status, :habit_id)
  end
end
