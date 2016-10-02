FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"
		activated true
		activated_at Time.zone.now

		factory :admin do
			admin true
		end

		factory :unactivated_user do
			activated false
			activated_at nil
		end
	end

	factory :workout do
		name "Test Workout"
		date Time.current.to_date
		user
	end	

	factory :exercise do
    name "MyString"
    description "MyText"
  end

	factory :workout_with_exercises do
		
	end	
	
end
