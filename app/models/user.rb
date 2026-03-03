class User < ApplicationRecord
  has_many :workout_records, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :workout_diaries, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 # 指定した名前の最新結果の記録を返す
 def latest_workout_for(exercise_name)
    return nil if exercise_name.blank?

    ex = exercises.find_by(name: exercise_name.strip)
    return nil unless ex

    workout_records.where(exercise: ex).order(performed_at: :desc).first
  end

  # 名前で前回の結果を返すか作成する
  def find_or_create_exercise(name)
    return nil if name.blank?
    exercises.find_or_create_by(name: name.strip)
  end
end
