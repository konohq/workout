class ChangeExerciseIdNullableInWorkoutDiaries < ActiveRecord::Migration[8.0]
  def change
    change_column_null :workout_diaries, :exercise_id, true
  end
end
