require 'rails_helper'

describe 'User admin' do
	let (:admin) { FactoryGirl.create(:admin) }
	let (:user) { FactoryGirl.create(:user) }

	context 'index page' do
		it "does not show delete links to non-admins" do
			log_in_test_user(:user)
			visit users_path
			expect(page).not_to have_link('delete')
		end

		it "should be able to delete another user" do
			log_in_test_user(:admin)
			visit users_path
			click_link('delete', href: user_path(user))
			expect(page).not_to have_link('delete', href: user_path(user))
		end
	end
end