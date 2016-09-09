require 'rails_helper'

describe "User login" do

	before { visit login_path }

	context "with invalid information" do
		before { click_button "Log in" }

		it { expect(page).to have_content('Log in') }
		it { expect(page).to have_title('Log in') }
		it { expect(page).to have_selector('div.alert.alert-danger') }

		context "after visiting another page" do
			before { click_link "Home" }
			it { expect(page).not_to have_selector('div.alert.alert-danger') }
		end
	end

	context "with valid information" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			fill_in 'Email', with: user.email
			fill_in 'Password', with: user.password
			click_button 'Log in'
		end
		it { expect(page).to have_link('Log out', href: logout_path) }
		it { expect(page).not_to have_link('Log in', href: login_path) }
		it { expect(page).to have_link('Profile', href: user_path(user)) }
		it { expect(page).to have_link('Settings', href: edit_user_path(user)) }

		context "followed by logout" do
			before { click_link 'Log out'}
			it { expect(page).to have_link('Log in', href: login_path) }
			it { expect(page).not_to have_link('Log out', href: logout_path) }
			it { expect(page).not_to have_link('Profile', href: user_path(user)) }
		end
	end
end