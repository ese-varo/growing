class HabitsQuery
  attr_reader :habits

  def initialize(habits)
    @habits = habits
  end

  def active
    @habits.where(status: false)
  end

  def archived
    @habits.where(status: true)
  end
end
