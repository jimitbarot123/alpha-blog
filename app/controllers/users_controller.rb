class UsersController < ApplicationController
  #load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    authorize! :edit, @user
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    #byebug
    #@user = User.find(params[:id])
    @user.destroy
    flash[:alert] = "#{@user.username} and all the related articles created by #{@user.username} have been deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # def require_same_user
  #   if logged_in? and current_user != @user and !current_user.admin?
  #     flash[:danger] = "You can only edit your own account"
  #     redirect_to root_path
  #   end
  # end
  #
  # def require_admin
  #   if logged_in? and !current_user.admin?
  #     flash[:danger] = "Only admin users can perform this action"
  #     redirect_to root_path
  #   end
  # end

end
