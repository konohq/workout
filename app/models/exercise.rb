class Exercise < ApplicationRecord
  belongs_to :user
  has_many :workout_records
  validates :name, presence: true
end
