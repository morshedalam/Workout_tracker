class User < ActiveRecord::Base
  has_secure_password
  has_many :user_workouts
  has_many :workouts, :through => :user_workouts
  # NEW WAY...has_many :workouts through: :user_workouts
  def name
    "#{first_name} #{last_name}"
  end

  def last_workout_of_exercise(exercise_id)
    workout = self.user_workouts.of_exercise(exercise_id).last
    return workout.present? ? workout.weight : ''
  end

  def name=(string)
    names = string.split(" ")
    self.first_name, self.last_name = case names.count
      when 1,2
        names
      when 3
        [names.first, names.last]
    end
  end
end
