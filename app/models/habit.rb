class Habit < ApplicationRecord
  belongs_to :user
  validates :name, :description, :start_date, :end_date, presence: true

  def start_date_format
    self.start_date.to_s(:long) 
  end
  
  def end_date_format
    self.end_date.to_s(:long) 
  end
end
