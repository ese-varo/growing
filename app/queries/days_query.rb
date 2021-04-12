class DaysQuery
  attr_reader :days

  def initialize(habit)
    @days = habit.days
  end

  def today
    @days.where(date: Date.today)
  end
end
