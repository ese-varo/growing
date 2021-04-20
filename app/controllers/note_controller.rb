class NoteController < ApplicationController
  before_action :authenticate_user! 

  def create
    @day = Day.find(params[:day_id])
    @note = Note.create(note_params)
    if @note.valid?
      respond_to :js
    else 
      flash[:danger] = "Note not saved"
      redirect_to habit_path(@day.habit_id)
    end
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_update_params)
      @day = Day.find(@note.noteable.id)
      respond_to :js
    else 
      flash[:danger] = "Note not updated"
      redirect_to habits_path
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:success] = "Note deleted"
      habit_id = @note.noteable.habit_id
      redirect_to habit_path(habit_id)
    end
  end

  private
  def note_params
    params.require(:note).permit(:description).merge(noteable: @day)
  end

  def note_update_params
    params.require(:note).permit(:description)
  end
end
