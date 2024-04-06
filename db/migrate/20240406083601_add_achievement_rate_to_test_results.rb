class AddAchievementRateToTestResults < ActiveRecord::Migration[7.1]
  def change
    add_column :test_results, :achievement_rate, :float
  end
end
