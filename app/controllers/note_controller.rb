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
      redirect_to habit_path(day_habit.habit_id)
    end
  end

  def update
    @note = Note.find(params[:id])
    @note.update(description: params[:description])
    if @note.valid?
      flash[:success] = "Note updated"
      respond_to do |format|
        format.js
      end
    else 
      flash[:danger] = "Note not updated"
      redirect_to habits_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    habit_id = @note.noteable.habit_id
    if @note.destroy
      flash[:success] = "Note deleted"
      redirect_to habit_path(habit_id)
    else 
      flash[:danger] = "Note not deleted"
      redirect_to habit_path(habit_id)
    end
  end
end
