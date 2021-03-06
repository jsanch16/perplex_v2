class WorkoutsController < ApplicationController
	before_action :logged_in_user, only: [:create, :show, :edit, :update, :destroy]
	before_action :correct_user, only: :destroy

	def new
		@workout = current_user.workouts.build if logged_in?
	end

	def create
		@workout = current_user.workouts.build(workout_params)
		@exercises = get_exercises(params[:options])
		if @workout.save
			render 'show'
		else
			render 'new'
		end
	end

	def destroy
		@workout.destroy
		flash[:success] = "Workout deleted"
		redirect_to request.referrer || root_url
	end

	def show
		@workout = current_user.workouts.find_by(id: params[:id])
		@exercises = @workout.exercises
	end

	private

	def workout_params
		params.require(:workout).permit(:name, :date, :notes)
	end

	def correct_user
		@workout = current_user.workouts.find_by(id: params[:id])
		redirect_to root_url if @workout.nil?
	end

	def get_exercises(options)
		options.each_with do |muscle, number|
			#get the ids of all the exercises
			Exercise.where("name = ?", muscle)
			

		end
	end
end
