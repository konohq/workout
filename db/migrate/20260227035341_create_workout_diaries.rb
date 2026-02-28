class CreateWorkoutDiaries < ActiveRecord::Migration[8.0]
  def change
    create_table :workout_diaries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.datetime :performed_at
      t.text :memo

      t.timestamps
    end
  end
end
