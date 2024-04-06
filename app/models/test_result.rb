class TestResult < ApplicationRecord
  belongs_to :user
  belongs_to :test_info

  has_many :subjects, dependent: :restrict_with_exception
  
end
