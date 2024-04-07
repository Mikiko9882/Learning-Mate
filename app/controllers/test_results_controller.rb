class TestResultsController < ApplicationController
  def index
    @q = current_user.test_results.ransack(params[:q])
    @test_results = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
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

  def edit
    @test_result = current_user.test_results.find(params[:id])
  end

  def update
    @test_result = current_user.test_results.find(params[:id])
    if @test_result.update(test_result_params)
      redirect_to @test_result, success: t('defaults.message.updated', item: TestResult.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: TestResult.model_name.human)
      render :edit
    end
  end

  def destroy
    @test_result = current_user.test_results.find(params[:id])
    @test_result.destroy!
    redirect_to test_results_path, success: t('defaults.message.deleted', item: TestResult.model_name.human)
  end

  def subject_achievement_rate
    @subjects = Subject.pluck(:subject_name)
    @data_by_subject = {}
    @subjects.each do |subject|
      @data_by_subject[subject] = {
        line_chart_data: TestResult.achievement_rate_by_subject(subject).map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] },
        scatter_chart_data: TestResult.scatter_chart_data_by_subject(subject)
      }
    end
  end

  private

  def test_result_params
    params.require(:test_result).permit(:test_name_id, :score, :max_score_id, :preparation_time_minutes, :subject_id)
  end
end
