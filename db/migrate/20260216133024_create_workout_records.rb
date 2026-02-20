class CreateWorkoutRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_records do |t|
      t.decimal :weight
      t.integer :reps
      t.text :memo
      t.datetime :performed_at
      t.references :user, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
