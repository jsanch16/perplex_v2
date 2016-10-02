class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :selected_exercises
  has_many :exercises, through: :selected_exercises
  scope :ordered, -> { order(date: :desc)}

  after_initialize :set_defaults
  validates(:date, presence: true)
  validates(:user_id, presence: true)
  validates(:name, presence: true)

  private

  def set_defaults
  	self.date ||= Time.current.to_date
  end
end
