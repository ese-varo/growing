class DaysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_day_habit, only: %i[show update]

  def show
    @note = @day_habit.note
    @checkpoint = @day_habit.checkpoint
    respond_to do |format|
      format.js
    end
  end

  def update
    if @day_habit.update(day_habit_params)
      flash[:success] = "Day checked successfully"
      respond_to :js
    else 
      flash[:danger] = "Error, day was not checked"
      redirect_to @day_habit.habit
    end
  end

  private

  def day_habit_params
    params.require(:day_habit).permit(:status, :date, :habit_id)
  end

  def set_day_habit
    @day_habit = Day.find(params[:id])
  end
end
