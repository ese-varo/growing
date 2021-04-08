class NoteController < ApplicationController
  def create
    day_habit = Day.find(params[:day_id])
    @note = Note.create(description: params[:description], noteable: day_habit)
    if @note.valid?
      flash[:success] = "Note saved"
    else 
      flash[:danger] = "Note not saved"
      respond_to do |format|
        format.html
      end
    end
  end
end
