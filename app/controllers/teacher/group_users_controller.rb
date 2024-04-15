class Teacher::GroupUsersController < Teacher::BaseController
  before_action :set_group

  def new
    @group_user = @group.group_users.new
    @users = User.all
  end

  def create
    @group_user = @group.group_users.new(group_user_params)
    if @group_user.save
      redirect_to teacher_group_path(@group), success: "User added to group successfully"
    else
      redirect_to teacher_group_path(@group), danger: "Failed to add user to group"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_user_params
    params.require(:group_user).permit(:user_id)
  end
end
