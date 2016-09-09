require 'rails_helper'
require 'support/utilities'

RSpec.describe UsersController, type: :controller do
	let (:user) { FactoryGirl.create(:user) }
	let (:other_user) { FactoryGirl.create(:user) }
	let (:admin_user) { FactoryGirl.create(:admin) }

  describe "GET #new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
	end

	describe "POST #create" do
		it "renders #new after an invalid user signup" do
  		post :create, user: { name: ' ', 
  													email: 'user@invalid.com', 
  													password: ' ', 
  													password_confirmation: ' '}
			expect(response).to render_template(:new)
		end
		it "redirects to root url after a valid user signup" do
			post :create, user: { name: 'Example', 
  													email: 'exampleuser@gmail.com', 
  													password: 'foobar', 
  													password_confirmation: 'foobar'}
  		expect(response).to redirect_to(root_url)
		end
	end

	describe "GET #edit" do
		it "redirects to login if user is not logged in" do
			get :edit, id: user.id
			expect(response).to redirect_to(login_url)
		end

		#it "redirects back to intended edit page after log in" do
			#get :edit, id: user.id
			#post 'sessions#create', session: { email: user.email, 
																	#password: user.password, 
																	#remember_me: '0'}
			#expect(response).to redirect_to(edit_user_path(user))
		#end

		it "redirects to root if incorrect user is logged in" do
			log_in_test_user(other_user)
			get :edit, id: user.id
			expect(response).to redirect_to(root_url)
		end

		it "shows edit page if user pertaining to edit path is logged in" do
			log_in_test_user(user)
			get :edit, id: user.id
			expect(response).to render_template(:edit)
		end
	end

	describe "PATCH #update" do
		let (:edited_name) { "Edited Name"}
		let (:edited_email) { "new@example.com"}

		context "with user not logged in" do
			it "redirects to login url" do
				patch :update, id: user.id , user: { name: edited_name,
																             email: edited_email,
																             password: user.password,
															    	         password_confirmation: user.password_confirmation }
				expect(flash).not_to be_empty
				expect(response).to redirect_to(login_url)
			end
		end

		context "with incorrect user logged in" do
			it "redirects to root url" do
				log_in_test_user(other_user)
				patch :update, id: user.id, user: { name: edited_name,
																						email: edited_email,
																						password: user.password,
																						password_confirmation: user.password_confirmation }
				expect(response).to redirect_to(root_url)
			end
		end

		context "with correct user logged in" do
			before { log_in_test_user(user) }

			it "re-renders #edit after an invalid update" do
				patch :update, id: user.id, user: { name: " ",
																						email: " ",
																						password: " ",
																						password_confirmation: " " } 
				expect(response).to render_template(:edit)
			end

			it "edits user and redirects to user_path after a valid update" do
				patch :update, id: user.id, user: { name: edited_name,
																						email: edited_email,
																						password: user.password,
																						password_confirmation: user.password_confirmation }
				user.reload
				expect(user.name).to eq edited_name
				expect(user.email).to eq edited_email
				expect(response).to redirect_to(@user)
			end

			it "doesnt allow editing of admin status through the web" do
				patch :update, id: user.id, user: { name: user.name,
																						email: user.email,
																						password: user.password,
																						password_confirmation: user.password_confirmation,
																						admin: true }
				user.reload
				expect(user.admin?).not_to be true
			end
		end
	end

	describe "GET #index" do
		it "redirects to login url if user is not logged in" do
			get :index
			expect(response).to redirect_to(login_url)
		end
	end

	describe "DELETE #destroy" do

		it "redirects to login url if user is not logged in" do
			delete :destroy, id: other_user.id
			expect(response).to redirect_to(login_url)
		end

		it "redirects to root url if logged in user is not admin" do
			log_in_test_user(user)
			delete :destroy, id: other_user.id
			expect(response).to redirect_to(root_url)
		end

		it "deletes the selected user" do
			log_in_test_user(admin_user)
			delete :destroy, id: other_user.id
			expect(User.where(id: other_user.id)).not_to exist
			expect(response).to redirect_to(users_url)
		end

	end

end
