class CheckpointController < ApplicationController
  before_action :set_day, only: %i[create update]
  before_action :set_habit, only: :update
  before_action :set_checkpoint, only: %i[update destroy toggle_status]

  def new
  end

  def create
    @checkpoint = @day.build_checkpoint(checkpoint_params)
    if @checkpoint.save
      respond_to :js
    else
      redirect_to @habit, danger: "Checkpoint not created"
    end
  end

  def update
    @checkpoint.update(checkpoint_params)
    if @checkpoint.save
      respond_to :js
    else
      redirect_to @habit, danger: "Checkpoint not updated"
    end
  end

  def destroy
    @day = Day.find(@checkpoint.day_id)
    @checkpoint.destroy
    respond_to :js
  end

  def toggle_status
    @checkpoint.toggle_status
    if @checkpoint.save
      respond_to :js
    else
      redirect_to @checkpoint.habit, danger: "Checkpoint wasn't checked correctly"
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
