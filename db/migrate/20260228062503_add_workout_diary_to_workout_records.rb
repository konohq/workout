class AddWorkoutDiaryToWorkoutRecords < ActiveRecord::Migration[8.0]
  def change
    # まずは NULL 許可で追加
    add_reference :workout_records, :workout_diary, null: true, foreign_key: true

    # 既存レコードに仮の diary を作って関連付け
    WorkoutRecord.reset_column_information
    WorkoutRecord.find_each do |record|
      diary = WorkoutDiary.find_or_create_by(user_id: record.user_id, date: record.performed_at.to_date)
      record.update!(workout_diary_id: diary.id)
    end

    # その後に NOT NULL 制約を追加
    change_column_null :workout_records, :workout_diary_id, false
  end
end
