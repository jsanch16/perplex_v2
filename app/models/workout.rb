class Workout < ActiveRecord::Base
  belongs_to :user
  validates(:date, presence: true)
  validates(:user_id, presence: true)
end
