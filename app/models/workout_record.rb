class WorkoutRecord < ApplicationRecord
  belongs_to :user
  belongs_to :workout_diary
  belongs_to :exercise
  validates :performed_at, presence: true
  validates :reps, presence: true, numericality: { greater_than: 0, only_integer: true }

# 各部位ごとの前回記録の取得

def previous_records_by_body_part
  parts = [ exercise.body_part ]
  parts.each_with_object({}) do |part, result|
    result[part] = previous_record_for(part)
  end
end


  # 一部位の前回記録を取得
  def previous_record_for(body_part)
    user.workout_records
        .joins(:exercise)
        .where(exercises: { body_part: body_part })
        .where("workout_records.performed_at < ?", performed_at)
        .distinct
        .order(performed_at: :desc)
        .first
  end
end
