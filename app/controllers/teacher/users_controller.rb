class Teacher::UsersController < Teacher::BaseController
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end
  
  private

  
  def user_params
    params.require(:user).permit(:login_id, :password, :password_confirmation, :last_name, :first_name, :nickname, :grade_id, :user_class_id)
  end
end
