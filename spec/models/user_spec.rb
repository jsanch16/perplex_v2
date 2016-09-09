require 'rails_helper'

RSpec.describe User, type: :model do

	before { @user = User.new(name: "Example User", email: "user@example.com", 
														password: "foobar", password_confirmation: "foobar") }
	subject { @user }

	it { should be_valid }
	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }


	it "is invalid without a name" do
		@user.name = " "
		expect(@user).not_to be_valid
	end

	it "it is invalid without an email present" do
		@user.email = " " 
		expect(@user).not_to be_valid
	end

	it "is invalid with a name that's too long" do
		@user.name = "a" * 300 
		expect(@user).not_to be_valid
	end

	it "is invalid with an email that's too long" do
		@user.email = "a" * 260 + "@example.com" 
		expect(@user).not_to be_valid
	end

	it "accepts valid email addresses" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
    	@user.email = valid_address

    	expect(@user).to be_valid
    end
	end

	it "rejects invalid email addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]
   	invalid_addresses.each do |invalid_address|
   		@user.email = invalid_address

   		expect(@user).not_to be_valid
   	end
	end

	it "accepts only unique email addresses" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save

		expect(duplicate_user).not_to be_valid
	end

	it "downcases emails before saving" do
		mixed_case_email = "Foo@ExAMPle.CoM"
		@user.email = mixed_case_email
		@user.save

		expect(@user.reload.email).to eq mixed_case_email.downcase
	end

	it "rejects a blank password" do
		@user.password = @user.password_confirmation = " "
		expect(@user).not_to be_valid
	end

	it "is invalid with passwords that are too small" do
		@user.password = @user.password_confirmation = "a" * 3
		expect(@user).not_to be_valid
	end

	it "authenticated? should return false for a user with nil digest" do
		expect(@user.authenticated?(:remember,'')).to eq false
	end

end
