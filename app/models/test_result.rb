class TestResult < ApplicationRecord
  belongs_to :test_name
  belongs_to :max_score
  belongs_to :subject
  belongs_to :user

  before_save :calculate_achievement_rate

  validate :achievement_rate_within_range

  def display_preparation_time
    hours = preparation_time_minutes / 60
    minutes = preparation_time_minutes % 60
    "#{hours}時間#{minutes}分"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["achievement_rate", "created_at", "id", "id_value", "max_score_id", "preparation_time_minutes", "score", "subject_id", "test_name_id", "updated_at", "user_id"]
  end

  def self.achievement_rate_by_subject(subject)
    joins(:subject, :test_name)
      .where(subjects: { subject_name: subject })
      .pluck(:test_name, :achievement_rate)
  end

  def self.scatter_chart_data_by_subject(subject)
    joins(:subject)
      .where(subjects: { subject_name: subject })
      .pluck(:preparation_time_minutes, :achievement_rate)
  end

  private

  def calculate_achievement_rate
    return if score.nil? || max_score.nil?

    max_score_value = max_score.max_score
    self.achievement_rate = ((score.to_f / max_score_value) * 100).round
  end

  def achievement_rate_within_range
    if score.present? && max_score.present?
      calculated_achievement_rate = ((score.to_f / max_score.max_score) * 100).round
      if calculated_achievement_rate > 100
        errors.add(:score, "達成率は100%を超えることはできません")
      end
    end
  end

  def self.user_test_results(user)
    where(user: user).pluck(:test_name, :achievement_rate)
  end

  def self.ransackable_associations(auth_object = nil)
    ["max_score", "subject", "test_name", "user"]
  end
  
end
