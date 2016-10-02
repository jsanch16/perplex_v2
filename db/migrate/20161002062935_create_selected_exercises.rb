class CreateSelectedExercises < ActiveRecord::Migration
  def change
    create_table :selected_exercises do |t|
      t.integer :exercise_id
      t.integer :workout_id

      t.timestamps null: false
    end
    add_index :selected_exercises, :workout_id
    add_index :selected_exercises, [:exercise_id, :workout_id]
  end
end
