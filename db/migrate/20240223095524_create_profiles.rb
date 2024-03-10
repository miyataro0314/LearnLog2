class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.integer :week_goal
      t.text :mantra
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
