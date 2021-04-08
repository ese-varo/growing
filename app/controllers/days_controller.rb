class DaysController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_to do |format|
      format.js
    end
  end
end
