class ExercisesController < ApplicationController
  before_action :admin_user, only: [:create, :new, :edit, :update, :destroy]

  def index
    @exercises = Exercise.paginate(page: params[:page])
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      redirect_to @exercise
    else
      render 'new'
    end
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])
    if @exercise.update_attributes(exercise_params)
      flash[:success] = "Exercise updated"
      redirect_to @exercise
    else
      render 'edit'
    end
  end

  def destroy
    Exercise.find(params[:id]).destroy
    flash[:success] = "Exercise deleted"
    redirect_to exercises_url
  end

  private

    def exercise_params
      params.require(:exercise).permit(:name, :description)
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
