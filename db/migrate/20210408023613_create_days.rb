class CreateDays < ActiveRecord::Migration[6.1]
  def change
    create_table :days do |t|
      t.boolean :status
      t.text :description
      t.date :date
      t.references :habit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
