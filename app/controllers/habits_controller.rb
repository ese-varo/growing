class HabitsController < ApplicationController
  def index
    @habit = Habit.new
  end
end
