class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: %i[show edit update]

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

  def show
    @habit_days = @habit.days_order_by_date
  end

  def edit; end

  def update
    if @habit.update(habit_params)
      flash[:success] = 'Habit updated successfully'
      redirect_to @habit
    else
      flash[:danger] = 'Error habit did not update'
      redirect_to habits_path
    end
  end

  def set_habit
    @habit = Habit.find(params[:id])
    @note = Note.new
    @day_habit = day_habit(@habit)
    @day_note = @day_habit.note if @day_note
  end

  def day_habit(habit)
    DaysQuery.new(@habit).today.first
  end

  def end_date_param
    raise MissingAttributeError unless params[:habit][:habit_duration]

    if (params[:_method] === 'patch')
      @habit.start_date.to_date + params[:habit][:habit_duration].to_i.days - 1.day
    else
      params[:habit][:start_date].to_date + params[:habit][:habit_duration].to_i.days - 1.day
    end
  rescue StandardError
    flash[:info] = 'Invalid form'
  end

  def habit_params
    params.require(:habit).permit(:name, :description, :start_date).merge(end_date: end_date_param)
  end
end
