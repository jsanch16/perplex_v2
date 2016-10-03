# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  users.each { |user| user.workouts.create!(name: "Test Workout") }
end

Exercise.create!(name: "Dumbbell Skullcrushers", description: "Lay flat on a bench with an EZ curl bar. Position the bar in a bench press position and proceed to bring the bar down to your forehead. Lift the bar up and repeat this movement.")
Exercise.create!(name: "Flat Bench Press", description: "Lay flat on a bench press. Position the barbell around the center of your chest. Proceed to bring the bar down until it touches your chest and then bring it up and repeat this movement.")
Exercise.create!(name: "Barbell Back Squat", description: "Place the barbell along your traps muscles. Squat down to desired depth and bring the barbell up and repeat this movement.")
Exercise.create!(name: "Close Grip EZ Bar Curls", description: "Hold an EZ bar with a close grip. Curl the bar up while keeping your arms and shoulders from swinging up. Repeat this movement.")
Exercise.create!(name: "Dumbbell Shoulder Press", description: "Bring dumbells up to shoulder height. Press up and bring the weights back to shoulder height. Repeat this movement.")
Exercise.create!(name: "Lat Pulldown", description: "In a seated upright position, pull the bar down to around chest height and bring it up. Repeat this movement.")

