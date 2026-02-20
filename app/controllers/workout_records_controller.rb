class WorkoutRecordsController < ApplicationController
  before_action :authenticate_user!

  # 筋トレ記録一覧
  def index
    @workout_record =WorkoutRecord.all
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
    exercise = current_user.exercises.find_or_create_by!(name: exercise_name)
    raise "種目の保存に失敗しました" unless exercise.persisted?
    @workout_record = current_user.workout_records.new(
    workout_params.except(:name).merge(exercise_id: exercise.id)
  )

    if @workout_record.save
    redirect_to @workout_record, notice: "保存完了！"
    else
      flash.now[:alert] = @workout_record.errors.full_messages.join(", ")
      render :new , status: :unprocessable_entity
    end
  end

  # 筋トレ記録編集
  def edit
  end

  # 筋トレ記録更新
  def update
  end

  # 筋トレ記録削除
  def destroy
  end
  
  private
  def workout_params
    params.require(:workout_record).permit(:performed_at, :name, :weight, :reps, :memo)
  end
end
