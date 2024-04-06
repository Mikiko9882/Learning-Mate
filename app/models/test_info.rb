class TestInfo < ApplicationRecord
  before_validation :set_max_score_from_settings

  has_many :test_results, dependent: :destroy

  private

  def set_max_score_from_settings
    setting = TestSetting.find_by(test_name: test_name)
    self.max_score = setting.max_score if setting
  end
end
