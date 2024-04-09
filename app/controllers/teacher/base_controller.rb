class Teacher::BaseController < ApplicationController
  before_action :check_teacher
  layout 'teacher/layouts/application'

  private

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to teacher_login_path
  end

  def check_teacher
    redirect_to root_path, warning: t('defaults.message.not_authorized') unless current_user.teacher?
  end
end
