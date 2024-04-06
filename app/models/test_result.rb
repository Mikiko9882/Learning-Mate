class TestResult < ApplicationRecord
  belongs_to :test_name
  belongs_to :max_score
  belongs_to :subject
  belongs_to :user
end
