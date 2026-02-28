class User < ApplicationRecord
  has_many :workout_records, dependent: :destroy
  has_many :exercises, dependent: :destroy
  has_many :workout_diaries, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
