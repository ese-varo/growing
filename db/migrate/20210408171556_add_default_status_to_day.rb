class AddDefaultStatusToDay < ActiveRecord::Migration[6.1]
  def change
    change_column :days, :status, :boolean, default: false
  end
end
