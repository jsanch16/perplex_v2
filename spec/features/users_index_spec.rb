require 'rails_helper'
describe 'user visits the index page' do
	subject { page }
	before (:all) { 30.times {FactoryGirl.create(:user)} }
	after(:all)  { User.delete_all }

	context 'when not logged in' do
		before { visit users_path }
		it { is_expected.to have_title('Log in') }

	end

	context 'when logged in' do
		before do
			log_in_test_user_with_form(user)
			click_link('Users')
		end

		it { is_expected.to have_title('All users') }
		it { is_expected.to have_content('All users') }
		it { is_expected.to have_selector('div.pagination') }
		it 'lists out each user' do
			User.paginate(page: 1).each do |user|
				expect(page).to have_selector('li', text: user.name)
			end
		end
	end
end