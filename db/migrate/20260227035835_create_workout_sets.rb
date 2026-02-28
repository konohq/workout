class CreateWorkoutSets < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_sets do |t|
      t.references :workout_diary, null: false, foreign_key: true
      t.float :weight
      t.integer :reps
      t.text :memo

      t.timestamps
    end
  end
end
