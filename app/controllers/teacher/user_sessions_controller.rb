class Teacher::UserSessionsController < Teacher::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_teacher, only: %i[new create]
  layout 'layouts/teacher_login'
  
  def new; end
  
  def create
    @user = login(params[:login_id], params[:password])
    if @user
      redirect_to teacher_root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    logout
    redirect_to teacher_login_path, success: t('.success')
  end
end
