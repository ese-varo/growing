class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :description
      t.references :noteable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
