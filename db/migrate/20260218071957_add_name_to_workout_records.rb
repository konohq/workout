class AddNameToWorkoutRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :workout_records, :name, :string
  end
end
