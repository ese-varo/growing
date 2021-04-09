class CreateCheckpoints < ActiveRecord::Migration[6.1]
  def change
    create_table :checkpoints do |t|
      t.string :title
      t.boolean :status, default: false
      t.text :description
      t.date :due_date
      t.references :habit, null: false, foreign_key: true
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
