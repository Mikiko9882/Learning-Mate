class TestResultsController < ApplicationController
  def index
    @test_results = TestResult.all.includes(:user).order(created_at: :desc)
  end

  def new
    @test_result = TestResult.new
  end

  def create
    @test_result = current_user.test_results.build(test_result_params)
    if @test_result.save
      redirect_to test_results_path, success: t('defaults.message.created', item: TestResult.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: TestResult.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show 
  end

  private

  def test_result_params
    params.require(:test_result).permit(:test_name_id, :score, :max_score_id, :preparation_time_minutes, :subject_id)
  end
end
