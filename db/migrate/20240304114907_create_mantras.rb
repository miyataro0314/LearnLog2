class CreateMantras < ActiveRecord::Migration[7.1]
  def change
    create_table :mantras do |t|
      t.string :author
      t.string :body
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
