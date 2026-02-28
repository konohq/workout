class AddDateToWorkoutDiaries < ActiveRecord::Migration[8.0]
  def change
    add_column :workout_diaries, :date, :date
  end
end
