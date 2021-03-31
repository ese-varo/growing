class CreateHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :habits do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date
      t.boolean :status

      t.timestamps
    end
  end
end
