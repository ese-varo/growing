class AddDefaultValueToHabit < ActiveRecord::Migration[6.1]
  def change
    change_column :habits, :status, :boolean, default: false
  end
end
