class CreateDailyNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_notes do |t|
      t.date :date, null: false
      t.integer :today_goal, null: false
      t.string :quote
      t.integer :mood
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :daily_notes, :date
    add_index :daily_notes, %i[user_id date], unique: true
  end
end
