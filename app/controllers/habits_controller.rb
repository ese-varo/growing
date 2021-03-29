class HabitsController < ApplicationController
  before_action :set_habit, only: %i[show]

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

  def show
  end

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def end_date_param
    params[:habit][:start_date].to_date + params[:habit][:quantity].to_i.days
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date).merge(:end_date => end_date_param)
  end
end
