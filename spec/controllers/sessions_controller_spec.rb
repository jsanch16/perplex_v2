require 'rails_helper'
require 'support/utilities'

RSpec.describe SessionsController, type: :controller do

	let (:user) { FactoryGirl.create(:user) }

  describe "GET #new" do
    it "returns http success" do
    	get :new
      expect(response).to have_http_status(:success)
    end

    #possibly a route test
    #it "should render when visiting login page" do
    	#get login_path
			#expect(response).to render_template(:new)
		#end
  end

  describe "POST #create" do
  	context "with valid params" do
      before do
			  post :create, session: { email: user.email, 
																						  password: user.password, 
																						  remember_me: '1'}
      end

			it "should log in the user" do
				expect(test_user_logged_in?).to eq true
			end

			it "should redirect to user_path" do
				expect(response).to redirect_to(user_path(user))
			end

			it "should store remember cookie when 'remember me' is checked" do
				expect(cookies['remember_token']).not_to be_nil
			end
  	end

  	context "with invalid params" do
      before do
			  post :create, session: { email: ' ',
																		password: ' ',
																		remember_me: '0' }
      end
  		it "should render #new after trying to log in" do
				expect(response).to render_template(:new)
			end
  	end

  	context "with an unactivated user" do
  		before do
        user.update_attribute(:activated, false)
        user.reload
        post :create, session: { email: user.email, 
                                            password: user.password, 
                                            remember_me: '1'} 
      end 

  		it "should redirect to the root_path" do
				expect(response).to redirect_to(root_path)
  		end
  	end
  end

  describe "DELETE #destroy" do
  	before { delete :destroy }
  	it "should log out the user" do
			expect(test_user_logged_in?).to eq false
  	end

  	 it "should redirect to root url" do
  	 	expect(response).to redirect_to(root_path)
  	 end

  	 it "should not attempt to log out user again if already logged out" do
  	 		#delete logout_path
  	 end
  end

end



