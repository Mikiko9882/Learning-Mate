class TestResultsController < ApplicationController
  def index
    @test_results = TestResult.all.includes(:user).order(created_at: :desc)
  end
end
