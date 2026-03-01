class WorkoutRecordsController < ApplicationController
  before_action :authenticate_user!

  def previous_record
  exercise = current_user.exercises.find_by(name: params[:name].strip)
  record = exercise && current_user.workout_records.where(exercise: exercise).order(performed_at: :desc).first

  render json: { weight: record&.weight, reps: record&.reps }
end

  # 筋トレ記録一覧
  def index
    @workout_records = current_user.workout_records
                                   .includes(:exercise, :workout_diary)
                                   .order(performed_at: :desc)
  end

  # 筋トレ記録詳細
  def show
    @workout_record = current_user.workout_records
                                  .includes(:exercise, :workout_diary)
                                  .find(params[:id])
  end


  # 筋トレ記録作成
  def new
    diary = current_user.workout_diaries.find_or_create_by(date: Date.current)
    @workout_record = WorkoutRecord.new(
      performed_at: Time.current,
      workout_diary: diary
    )

    @previous_record = nil

  if params[:workout_record].present? && params[:workout_record][:name].present?
    exercise_name = params[:workout_record][:name].strip
    exercise = current_user.exercises.find_by(name: exercise_name)
    if exercise
    @previous_record = current_user.workout_records
                                   .where(exercise: exercise)
                                   .order(performed_at: :desc)
                                   .first
    end
  end
end

  # 筋トレ記録登録
  def create
    exercise_name = workout_record_params[:name].to_s.strip
    exercise = current_user.exercises.find_or_create_by(name: exercise_name)

    @workout_record = current_user.workout_records.new(
      workout_record_params.except(:name)
    )
    @workout_record.exercise = exercise

    if @workout_record.save
    redirect_to workout_records_path, notice: "保存しました"
    else
      render "new", status: :unprocessable_entity
    end
  end

  # 筋トレ記録編集
  def edit
    @workout_record = WorkoutRecord.find(params[:id])
  end

  # 筋トレ記録更新
  def update
    @workout_record = WorkoutRecord.find(params[:id])
    exercise_name = workout_record_params[:name].to_s.strip
    exercise = current_user.exercises.find_or_create_by(name: exercise_name)
    @workout_record.exercise = exercise


    if @workout_record.update(workout_record_params.except(:name))
      redirect_to workout_records_path, notice: "更新しました"
    else
      render "edit", status: :unprocessable_entity
    end
  end

  # 筋トレ記録削除
  def destroy
    @workout_record = WorkoutRecord.find(params[:id])
    @workout_record.destroy
    redirect_to workout_record_path, notice: "削除しました"
  end

  private
  def workout_record_params
    params.require(:workout_record).permit(:performed_at, :name, :weight, :reps, :memo, :workout_diary_id)
  end
end
