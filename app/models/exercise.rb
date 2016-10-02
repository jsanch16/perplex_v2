class Exercise < ActiveRecord::Base
	  has_many :selected_exercises
	 	has_many :workouts, through: :selected_exercises
end
