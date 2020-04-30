# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #load_and_authorize_resource

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # def after_sign_up_path_for(resource)
  #   redirect_to articles_path
  # end

  # def index
  #   @users = User.paginate(page: params[:page], per_page: 5)
  # end
  #
  # def show
  #   @user = User.find(params[:format])
  #   @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  # end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    @user = User.find(params[:format])
    #super
  end

  # PUT /resource
  def update
    @user = User.find_by(email: params[:user][:email])
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /resource
  # def destroy
  #   @user = User.find(params[:format])
  #   @user.destroy
  #   redirect_to users_path
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params
    params.require(:user).permit(:id, :username, :email, :password, :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
