class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #methods available to all controllers
  
  private

  	#Confirms a logged in user, if not logged in redirect to login
    def logged_in_user
      unless logged_in? 
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
