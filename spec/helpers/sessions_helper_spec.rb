require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
	let (:user) { FactoryGirl.create(:user) }

	describe "current_user" do
		before { remember(user) }
		it "returns the right user when session is nil(user opened a new browser)" do
			expect(user).to eq current_user
			expect(logged_in?).to be true
		end

		it "returns nil when remember_digest is wrong" do
			user.update_attribute(:remember_digest, User.digest(User.new_token))
			expect(current_user).to be nil
		end
	end


end
