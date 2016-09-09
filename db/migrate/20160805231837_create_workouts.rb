class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.datetime :date
      t.text :notes

      t.timestamps null: false
    end
    add_index :workouts, [:user_id, :date]
  end
end
