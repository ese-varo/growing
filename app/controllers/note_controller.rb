class NoteController < ApplicationController
  def create
    day_habit = Day.find(params[:day_id])
    @note = Note.create(description: params[:description], noteable: day_habit)
    if @note.valid?
      flash[:success] = "Note saved"
      respond_to do |format|
        format.js
      end
    else 
      flash[:danger] = "Note not saved"
      render habit_path(day_habit.habit_id)
    end
  end
end
