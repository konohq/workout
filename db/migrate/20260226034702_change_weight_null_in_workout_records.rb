class ChangeWeightNullInWorkoutRecords < ActiveRecord::Migration[8.0]
  def change
    change_column_null :workout_records, :weight, true
  end
end
