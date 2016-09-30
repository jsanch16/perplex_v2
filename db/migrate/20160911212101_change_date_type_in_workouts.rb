class ChangeDateTypeInWorkouts < ActiveRecord::Migration
  def change
  	change_column :workouts, :date, :date
  end
end
