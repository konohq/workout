class WorkoutRecordsController < ApplicationController
  before_action :authenticate_user!

  # 筋トレ記録一覧
  def index
    @workout_records = current_user.workout_records
                                   .includes(:exercise)
                                   .order(performed_at: :desc)
  end

  # 筋トレ記録詳細
  def show
    @workout_record = WorkoutRecord.find(params[:id])
    p @workout_records
  end

  # 筋トレ記録作成
  def new
    @workout_record = WorkoutRecord.new(
      performed_at: Time.current
    )
    end

  # 筋トレ記録登録
  def create
    exercise_name = workout_params[:name].to_s.strip
    exercise = current_user.exercises.find_or_create_by(name: exercise_name)
    @workout_record = current_user.workout_records.new(
      workout_params.except(:name)
    )
    @workout_record.exercise = exercise

    if @workout_record.save
    redirect_to @workout_record, notice: "保存完了！"
    else
      render 'new' , status: :unprocessable_entity
    end
  end

  # 筋トレ記録編集
  def edit
    @workout_record = WorkoutRecord.find(params[:id])
  end
  
  # 筋トレ記録更新
  def update
    @workout_record = WorkoutRecord.find(params[:id])
    if @workout_record.update(workout_params)
      redirect_to @workout_record
    else
      render 'edit', status: unprocessable_entity
    end
  end

  # 筋トレ記録削除
  def destroy
    @workout_record = WorkoutRecord.find(params[:id])
    @workout_record.destroy
    redirect_to workout_record_path
    
  end
  
  private
  def workout_params
    params.require(:workout_record).permit(:performed_at, :name, :weight, :reps, :memo)
  end
end
