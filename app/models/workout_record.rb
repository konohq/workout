class WorkoutRecord < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  validates :weight, :reps, :performed_at, presence: true
end
