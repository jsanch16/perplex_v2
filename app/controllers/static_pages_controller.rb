class StaticPagesController < ApplicationController
  def home
  	@workout = current_user.workouts.build if logged_in?
  end

  def about
  end

  def contact
  end
end
