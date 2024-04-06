class TestResult < ApplicationRecord
  belongs_to :test_name
  belongs_to :max_score
  belongs_to :subject
  belongs_to :user

  before_save :calculate_achievement_rate

  def display_preparation_time
    hours = preparation_time_minutes / 60
    minutes = preparation_time_minutes % 60
    "#{hours}時間#{minutes}分"
  end

  private

  def calculate_achievement_rate
    return if score.nil? || max_score.nil?

    max_score_value = max_score.max_score
    self.achievement_rate = ((score.to_f / max_score_value) * 100).round
  end

  def self.user_test_results(user)
    where(user: user).pluck(:test_name, :achievement_rate)
  end
end
