class DaysController < ApplicationController
  before_action :authenticate_user!

  def show
    @day_habit = Day.find(params[:id])
    @note = @day_habit.note
    @checkpoint = @day_habit.checkpoint
    # byebug
    respond_to do |format|
      format.js
    end
  end
end
