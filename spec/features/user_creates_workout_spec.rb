require 'rails_helper'

feature 'User creates workout' do
	let(:user){FactoryGirl.create(:user)}

	it "redirects to log in if not logged in" do
		expect(page.current_path).to eq login_path
	end

	context "with valid information" do
		before do
			log_in_test_user(user)
			visit 
		end
		
	end

	context "with invalid information" do
		before {log_in_test_user(user)}
	end

end