class AddNameDefaultToWorkouts < ActiveRecord::Migration
  def change
  	change_column :workouts, :name, :string, default: "Untitled Workout"
  end
end
