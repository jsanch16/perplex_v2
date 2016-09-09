require 'rails_helper'
require 'support/utilities'

describe "user tries to edit his settings" do
	let (:user) { FactoryGirl.create(:user) }
	let (:other_user) { FactoryGirl.create(:user) }
	subject { page }

	context "when not logged in" do
		before { visit edit_user_path(user) }
		it "will get redirected to the login page" do
		
		end
	end
	context "when not logged in as the correct user" do
		before do
			log_in_test_user_through_form(other_user)
		end
		it "redirects to root" do
			visit edit_user_path(user)
			expect(page.current_path).to eq root_path
		end
		
	end

	context "when logged in as the correct user" do
		before do
			log_in_test_user_through_form(user)
			visit edit_user_path(user)
		end

		it { is_expected.to have_title('Edit user') }
		it { is_expected.to have_content('Update your profile') }

		context "submitting invalid information" do
			before do
				fill_in "Name", with: " "
				fill_in "Email", with: " "
				click_button 'Save changes'
			end

			it "displays error message with invalid entries" do
				expect(page).to have_selector('div.alert.alert-danger')
			end
		end

		context "submitting valid information" do
			let (:edited_name) { "Edited Name" }
			let (:edited_email) { "new@example.com"}
			before do
				fill_in "Name", with: edited_name
				fill_in "Email", with: edited_email
				fill_in "Password", with: user.password
				fill_in "Confirmation", with: user.password
				click_button "Save changes"
			end

			it { is_expected.to have_title(edited_name) }
			it { is_expected.to have_selector('div.alert.alert-success') }
	    it { is_expected.to have_link('Log out', href: logout_path) }
	    it "should alert the user that the profile" do
	    	expect(page).to have_content("Profile updated")
	  	end
		end
	end
end