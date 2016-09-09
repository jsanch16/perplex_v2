require 'rails_helper'

describe "User sign up" do

	before { visit signup_path }

	context "with invalid information" do
		it "should not create a user" do
			expect{ click_button "Create my account" }.not_to change(User, :count)
		end
	end

	context "with valid information" do 
		before do
			fill_in "Name",         with: "Example User"
			fill_in "Email",        with: "user@example.com"
			fill_in "Password",     with: "foobar"
			fill_in "Password confirmation", with: "foobar"
		end
		it "should create a user" do
			expect { click_button "Create my account"}.to change(User,:count).by(1)
		end

		context "after user creation" do
			before { click_button "Create my account" }
			let (:user) { User.find_by(email: 'user@example.com') }

			it "redirects to root url" do
				expect(page.current_path).to eq root_path
			end

			it "notifies user to check email and activate" do
				expect(page).to have_content("Please check your email to activate your account.")
			end

			context "after user has activated account" do
				before do
					user.activate
					user.reload
					#change to accept workflow where user activates by email and get redirected to success page
				end
				it "has the link 'Log out'" do
					#expect(page).to have_link('Log out')
				end
				it "has the link with user's name" do
					#expect(page).to have_link(user.name)
				end
				it "flashes a successful 'Welcome' message" do
					#expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
				end
			end

			
		end
	end
end