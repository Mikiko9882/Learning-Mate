class Teacher::GroupsController < Teacher::BaseController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @groups = Group.all
    @user = User.find(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @user = User.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to teacher_groups_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to teacher_groups_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render "edit", status: :unprocessable_entity
    end
  end

  def add_user
    @group = Group.find(params[:id])
    @users = User.all
  end

  def create_group_user
    @group = Group.find(params[:id])
    user_ids = params[:user_ids]
    @group.users << User.where(id: user_ids)
    redirect_to teacher_group_path(@group), success: 'Users added to group successfully.'
  end

  private

  def group_params
    params.require(:group).permit(:group_name)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to teacher_groups_path
    end
  end
end
