class Teacher::GroupUsersController < Teacher::BaseController
  before_action :set_group

  def new
    @group_user = @group.group_users.new
    @users = User.all
  end

  def create
    user_ids = group_user_params.delete(:user_ids) # user_idsを取り出す
    user_ids.each do |user_id|
      @group.group_users.create(user_id: user_id)
    end

    redirect_to teacher_group_path(@group), success: "Users added to group successfully"
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_user_params
    params.require(:group_user).permit(user_ids: [])
  end
end
