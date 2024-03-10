class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.date :date, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.references :user, null: false, foreign_key: true
      t.references :daily_note, null: false, foreign_key: true
      t.timestamps
    end
  end
end
