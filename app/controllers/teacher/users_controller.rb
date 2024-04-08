class Teacher::UsersController < Teacher::BaseController
  before_action :set_user, only: %i[edit update show destroy]
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc).page(params[:page])
  end

  def new
    @user = User.new
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to teacher_users_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to teacher_user_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id]).decorate
    @average_achievement_rate = @user.average_achievement_rate
  end

  def destroy
    @user.destroy!
    redirect_to teacher_users_path, success: t('defaults.message.deleted', item: User.model_name.human)
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:login_id, :password, :password_confirmation, :last_name, :first_name, :nickname, :grade_id, :user_class_id)
  end
end
