class UserSessionsController < ApplicationController

  def new; end

  def create
    @user = login(params[:login_id], params[:password])
    if @user
      redirect_back_or_to root_path, notice: ,success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    logout
    redirect_to new_user_session_path, success: t('.success')
  end
end
