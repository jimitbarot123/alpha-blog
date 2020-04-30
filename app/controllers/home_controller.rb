class HomeController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update]
  load_and_authorize_resource, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @user = User.find(params[:format])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # def edit
  #   @user = User.find(params[:format])
  # end
  #
  # def update
  #   @user = User.find(params[:format])
  #   if @user.update(user_params)
  #     flash[:notice] = "Your account information was successfully updated"
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end

  def destroy
    #byebug
    @user = User.find(params[:format])
    @user.destroy
    flash[:alert] = "#{@user.username} and all the related articles created by #{@user.username} have been deleted"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
