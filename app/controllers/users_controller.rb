class UsersController < ApplicationController
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.includes(:test_results).find(params[:id]).decorate
    @average_achievement_rate = @user.average_achievement_rate
    @test_results_data = @user.test_results.order(created_at: :asc).pluck(:test_name, :achievement_rate).map.with_index { |(test_name, achievement_rate), index| ["#{test_name} (#{index + 1})", achievement_rate] }
    @test_results_data2 = @user.test_results.pluck(:preparation_time_minutes, :score)
  end

  private
    
  def user_params
    params.require(:user).permit(:login_id, :password, :password_confirmation, :last_name, :first_name, :nickname, :grade_id, :user_class_id)
  end
end
