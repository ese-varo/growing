class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: %i[show]

  def index
    @habit = Habit.new
    @habits = HabitsQuery.new(current_user.habits)
  end

  def create
    @habit = current_user.habits.create(habit_params)
    if @habit.valid?
      flash[:success] = 'Habit created successfully'
      redirect_to @habit
    else
      flash[:danger] = 'Error habit not created'
      redirect_to habits_path
    end
  end

  def show; end

  def set_habit
    @habit = Habit.find(params[:id])
    @note = Note.new
  end

  def end_date_param
    raise MissingAttributeError unless params[:habit][:habit_duration]

    params[:habit][:start_date].to_date + params[:habit][:habit_duration].to_i.days
  rescue StandardError
    flash[:info] = 'Invalid form'
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date).merge(end_date: end_date_param)
  end
end
