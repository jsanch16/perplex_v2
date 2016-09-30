require 'rails_helper'
require 'support/utilities'

RSpec.describe WorkoutsController, type: :controller do
		let(:user){FactoryGirl.create(:user)}
		let(:other_user){FactoryGirl.create(:user)}
		let(:workout) {FactoryGirl.create(:workout, user_id: user.id)}

	describe 'GET #new' do
		it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
	end

	describe 'POST #create' do
		it 'redirects to login when user is not logged in' do
			post :create, workout: {name: "Workout Name", date: Time.current.to_date}
			expect(response).to redirect_to(login_url)
		end
	end

	describe 'DELETE #destroy' do
		it 'redirects to login when user is not logged in' do
			delete :destroy, id: workout.id
			expect(response).to redirect_to(login_url)
		end

		it "redirects if wrong user tries to delete other user's workout" do
			log_in_test_user(other_user)
			delete :destroy, id: workout.id
			expect(response).to redirect_to(root_url)
		end
	end

end
