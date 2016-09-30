require 'rails_helper'

RSpec.describe Workout, type: :model do
	let (:user) {FactoryGirl.create(:user)}
	before do 
		@workout = user.workouts.build( name: "Leg Day", notes: "no notes" )
	end

	it "is invalid without a user_id" do
		@workout.user_id = ""
		expect(@workout).not_to be_valid
	end

	it "is invalid without a name" do
		@workout.name = ""
		expect(@workout).not_to be_valid
	end

	it "is invalid without a date" do
		@workout.date = ""
		expect(@workout).not_to be_valid
	end

	it "is valid without notes" do
		@workout.notes = ""
		expect(@workout).to be_valid
	end

	it "defaults name to 'Untitled Workout' if left blank" do
		@untitled_workout = user.workouts.create()
		expect(@untitled_workout.name).to eq "Untitled Workout"
	end

	it "defaults the date to the current date" do
		@nodate_workout = user.workouts.create()
		expect(@nodate_workout.date).to eq Time.current.to_date
	end

	it "orders workouts by most recent date with ordered scope" do
		@workout.date = "Thursday, 22 Sep 2016"
		@workout.save
		@second_workout = user.workouts.create(name: "Second Workout")
		expect(user.workouts.ordered.first).to eq @second_workout
	end


end

