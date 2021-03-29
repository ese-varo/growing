class HabitsController < ApplicationController
  def index
    @habit = Habit.new
  end

  def create
    @habit = Habit.create(habit_params)

    if @habit.valid?
      redirect_to @habit 
    else
      render :index
    end
  end

  def end_date_param
    params[:habit][:start_date].to_date + params[:habit][:quantity].to_i.days
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date).merge(:end_date => end_date_param)
  end
end
