class WorkoutRecord < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  validates :performed_at, presence: true
  validates :reps, presence: true, numericality: { greater_than: 0, only_integer: true}
end